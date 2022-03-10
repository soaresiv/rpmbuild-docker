Name:    %{package_name}
Summary: Most simple RPM package
Version: %{package_version}
Release: %{package_release}
License:    FIXME

%description
This is my first RPM package, which does nothing.


%build
cat > hello-world.sh <<EOF
#!/usr/bin/bash
echo Hello world
EOF

%prep
# we have no source, so nothing here

%install
mkdir -p %{buildroot}/usr/bin/
install -m 755 hello-world.sh %{buildroot}/usr/bin/hello-world.sh

%files
/usr/bin/hello-world.sh

%changelog
* Fri Mar 04 2022 mypackage - %{package_version} %{package_release}
-
