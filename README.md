<div align="center">
  <h1
    style="font-size: 3rem; font-weight: bold; color: rgb(150, 108, 190);"
    >
    Minimal-Grub
  </h1>
  <h3>
    A minimalistic Grub theme for designed to keep your boot menu clean and simple.
  </h3>
</div>

## About

Minimal-Grub is a simple and clean Grub theme that focuses on providing a minimalistic and elegant boot menu experience. It is designed to be easy to use and customize, while still providing all the necessary functionality for booting your operating system.
The theme features a clean and modern design, with a focus on simplicity and usability. It is fully responsive and works on all screen sizes, making it a great choice for both desktop and laptop users.

## Installation

### From Source

To install Minimal-Grub, follow these steps:

1. Clone the repository to your local machine:

```bash
git clone https://github.com/MichaelSchaecher/grub-theme.git
```

2. Navigate to the cloned directory:

```bash
cd grub-theme
```

3. Copy the theme to the Grub themes directory:

```bash
sudo cp -r . /usr/share/grub/themes/minimal-grub
```

4. Update the Grub configuration file to use the new theme:

```bash
sudo nano /etc/default/grub
```

5. Add the following line to the file:

```bash
GRUB_THEME="/usr/share/grub/themes/minimal-grub/theme.txt"
```

6. Save the file and exit the editor by pressing `CTRL + S` and `CTRL + X`.
7. Update the Grub configuration:

```bash
sudo update-grub
```

### From Package

If you are use a Debian/Ubuntu based distribution, you can install Minimal-Grub from the AUR using the following command:

```bash
wget -c https://github.com/MichaelSchaecher/grub-theme/releases/download/current/grub-theme-minimal_1.0.0_all.deb
sudo dpkg -i grub-theme-minimal_1.0.0_all.deb
```
