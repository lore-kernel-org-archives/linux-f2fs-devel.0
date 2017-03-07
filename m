From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH v2] f2fscrypt: add a tool for encryption
 management in the f2fs filesystem
Date: Tue, 7 Mar 2017 10:34:51 +0800
Message-ID: <9ad0a9c5-e386-a233-3724-7ab981ed61b4@gmail.com>
References: <7ac27d31-fb60-995e-ecf6-a63b48bc9423@gmail.com>
	<20170307013905.GA6423@jaegeuk.local>
	<c1e0f8c9-d497-f478-8b8e-c3d24c5331b0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cl4xz-0003gm-PI
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Mar 2017 02:35:11 +0000
Received: from mail-it0-f65.google.com ([209.85.214.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cl4xw-0003VK-JQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Mar 2017 02:35:11 +0000
Received: by mail-it0-f65.google.com with SMTP id f203so939218itf.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 06 Mar 2017 18:35:08 -0800 (PST)
In-Reply-To: <c1e0f8c9-d497-f478-8b8e-c3d24c5331b0@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

It's migrated from e4crypt.
Adds an example to the f2fscrypt manpages.

v2,
1. migrate those micro defines for encrypt to f2fs internal
2. drop unless of libsha etc.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 tools/Makefile.am |   5 +-
 tools/f2fscrypt.8 | 102 ++++++
 tools/f2fscrypt.c | 916 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/sha512.c    | 323 +++++++++++++++++++
 4 files changed, 1345 insertions(+), 1 deletion(-)
 create mode 100644 tools/f2fscrypt.8
 create mode 100644 tools/f2fscrypt.c
 create mode 100644 tools/sha512.c

diff --git a/tools/Makefile.am b/tools/Makefile.am
index 69a0bb1..5a9303f 100644
--- a/tools/Makefile.am
+++ b/tools/Makefile.am
@@ -2,7 +2,10 @@
 
 AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
 AM_CFLAGS = -Wall
-sbin_PROGRAMS = f2fstat fibmap.f2fs parse.f2fs
+sbin_PROGRAMS = f2fstat fibmap.f2fs parse.f2fs f2fscrypt
 f2fstat_SOURCES = f2fstat.c
 fibmap_f2fs_SOURCES = fibmap.c
 parse_f2fs_SOURCES = f2fs_io_parse.c
+f2fscrypt_SOURCES = f2fscrypt.c sha512.c
+f2fscrypt_LDFLAGS = -luuid
+dist_man_MANS = f2fscrypt.8
diff --git a/tools/f2fscrypt.8 b/tools/f2fscrypt.8
new file mode 100644
index 0000000..a60adc8
--- /dev/null
+++ b/tools/f2fscrypt.8
@@ -0,0 +1,102 @@
+.TH F2FSCRYPT 8
+.SH NAME
+f2fscrypt \- f2fs filesystem encryption utility
+.SH SYNOPSIS
+.B f2fscrypt add_key -S \fR[\fB -k \fIkeyring\fR ] [\fB-v\fR] [\fB-q\fR] [ \fI path\fR ... ]
+.br
+.B f2fscrypt new_session
+.br
+.B f2fscrypt get_policy \fIpath\fR ...
+.br
+.B f2fscrypt set_policy \fIpolicy path\fR ...
+.SH DESCRIPTION
+.B f2fscrypt
+performs encryption management for f2fs file systems.
+.SH COMMANDS
+.TP
+.B f2fscrypt add_key -S \fR[\fB -k \fIkeyring\fR ] [\fB-v\fR] [\fB-q\fR] [ \fI path\fR ... ]
+Prompts the user for a passphrase and inserts it into the specified
+keyring.  If no keyring is specified, f2fscrypt will use the session
+keyring if it exists or the user session keyring if it does not.
+.IP
+If one or more directory paths are specified, f2fscrypt will try to
+set the policy of those directories to use the key just entered by
+the user.
+.TP
+.B f2fscrypt get_policy \fIpath\fR ...
+Print the policy for the directories specified on the command line.
+.TP
+.B f2fscrypt new_session
+Give the invoking process (typically a shell) a new session keyring,
+discarding its old session keyring.
+.TP
+.B f2fscrypt set_policy \fIpolicy path\fR ...
+Sets the policy for the directories specified on the command line.
+All directories must be empty to set the policy; if the directory
+already has a policy established, f2fscrypt will validate that the
+policy matches what was specified.  A policy is an encryption key
+identifier consisting of 16 hexadecimal characters.
+.SH NOTES
+The target directory must be empty.
+.SH EXAMPLE
+.nf
+Formats a f2fs filesytem that supports encrypt.
+
+.ft R
+# mkfs.f2fs -O encrypt /dev/sdxx
+# mount /dev/sdxx /encrypted/
+# mkdir /encrypted/dir
+
+.nf
+First create the key in the keyring use an simple salt
+(or generate a random salt).
+Then use it to set the policy for the directory to be encrypted.
+
+.ft R
+# f2fscrypt add_key -S 0x1234
+  Enter passphrase (echo disabled):
+  Added key with descriptor [28e21cc0c4393da1]
+
+# f2fscrypt set_policy 28e21cc0c4393da1 /encrypted/dir
+  Key with descriptor [28e21cc0c4393da1] applied to /encrypted/dir.
+
+# touch /encrypted/dir/test.txt
+# ls -l /encrypted/dir/
+  -rw-r--r--. 1 root root 0 Mar  5 21:41 test.txt
+
+.nf
+After each reboot, the same command can be used set the key for
+decryption of the directory and its descendants.
+
+.ft R
+# ls -l /encrypted/dir/
+  -rw-r--r--. 1 root root 0 Mar  5 21:41 zbx7tsUEMLzh+AUVMkQcnB
+
+# f2fscrypt get_policy /encrypted/dir/
+  /encrypted/dir/: 28e21cc0c4393da1
+
+# f2fscrypt add_key -S 0x1234
+  Enter passphrase (echo disabled):
+  Added key with descriptor [28e21cc0c4393da1]
+
+# ls -l /encrypted/dir/
+  -rw-r--r--. 1 root root 0 Mar  5 21:41 test.txt
+
+.nf
+Show process keyrings.
+
+.ft R
+# keyctl show
+  Session Keyring
+    84022412 --alswrv      0     0  keyring: _ses
+   204615789 --alswrv      0 65534   \\_ keyring: _uid.0
+   529474961 --alsw-v      0     0   \\_ logon: f2fs:28e21cc0c4393da1
+
+.SH AUTHOR
+Written by Kinglong Mee <kinglongmee@gmail.com>,
+Migrated from e4crypt that Written by Michael Halcrow <mhalcrow@google.com>,
+Ildar Muslukhov <muslukhovi@gmail.com>, and Theodore Ts'o <tytso@mit.edu>
+.SH SEE ALSO
+.BR keyctl (1),
+.BR mkfs.f2fs (8),
+.BR mount (8).
diff --git a/tools/f2fscrypt.c b/tools/f2fscrypt.c
new file mode 100644
index 0000000..48ea5f6
--- /dev/null
+++ b/tools/f2fscrypt.c
@@ -0,0 +1,916 @@
+/*
+ * f2fscrypt.c - f2fs encryption management utility
+ *
+ * Authors: Kinglong Mee <kinglongmee@gmail.com>
+ *
+ * Copied from e4crypt that for ext4 filesystem.
+ * Authors: Michael Halcrow <mhalcrow@google.com>,
+ *	    Ildar Muslukhov <ildarm@google.com>
+ */
+
+#ifndef _LARGEFILE_SOURCE
+#define _LARGEFILE_SOURCE
+#endif
+
+#ifndef _LARGEFILE64_SOURCE
+#define _LARGEFILE64_SOURCE
+#endif
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include "config.h"
+#include <assert.h>
+#include <errno.h>
+#include <getopt.h>
+#include <dirent.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <mntent.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <termios.h>
+#include <unistd.h>
+#include <signal.h>
+#include <linux/fs.h>
+#include <uuid/uuid.h>
+
+#if !defined(HAVE_ADD_KEY) || !defined(HAVE_KEYCTL)
+#include <sys/syscall.h>
+#endif
+#ifdef HAVE_SYS_KEY_H
+#include <sys/key.h>
+#endif
+
+#define F2FS_MAX_KEY_SIZE		64
+#define F2FS_MAX_PASSPHRASE_SIZE	1024
+#define F2FS_MAX_SALT_SIZE		256
+
+/* Encryption algorithms, key size and key reference len */
+#define F2FS_ENCRYPTION_MODE_INVALID		0
+#define F2FS_ENCRYPTION_MODE_AES_256_XTS	1
+#define F2FS_ENCRYPTION_MODE_AES_256_GCM	2
+#define F2FS_ENCRYPTION_MODE_AES_256_CBC	3
+#define F2FS_ENCRYPTION_MODE_AES_256_CTS	4
+
+#define F2FS_AES_256_XTS_KEY_SIZE		64
+#define F2FS_AES_256_GCM_KEY_SIZE		32
+#define F2FS_AES_256_CBC_KEY_SIZE		32
+#define F2FS_AES_256_CTS_KEY_SIZE		32
+#define F2FS_MAX_KEY_SIZE			64
+
+/* Password derivation constants */
+#define F2FS_MAX_PASSPHRASE_SIZE		1024
+#define F2FS_MAX_SALT_SIZE			256
+#define F2FS_PBKDF2_ITERATIONS			0xFFFF
+
+/* special process keyring shortcut IDs */
+#define KEY_SPEC_THREAD_KEYRING		-1
+#define KEY_SPEC_PROCESS_KEYRING	-2
+#define KEY_SPEC_SESSION_KEYRING	-3
+#define KEY_SPEC_USER_KEYRING		-4
+#define KEY_SPEC_USER_SESSION_KEYRING	-5
+#define KEY_SPEC_GROUP_KEYRING		-6
+
+#define KEYCTL_GET_KEYRING_ID		0
+#define KEYCTL_JOIN_SESSION_KEYRING	1
+#define KEYCTL_DESCRIBE			6
+#define KEYCTL_SEARCH			10
+#define KEYCTL_SESSION_TO_PARENT	18
+
+/*
+ * File system encryption support
+ */
+/* Policy provided via an ioctl on the topmost directory */
+#define F2FS_KEY_DESCRIPTOR_SIZE	8
+#define F2FS_KEY_REF_STR_BUF_SIZE ((F2FS_KEY_DESCRIPTOR_SIZE * 2) + 1)
+
+struct f2fs_fscrypt_policy {
+	__u8 version;
+	__u8 contents_encryption_mode;
+	__u8 filenames_encryption_mode;
+	__u8 flags;
+	__u8 master_key_descriptor[F2FS_KEY_DESCRIPTOR_SIZE];
+} __attribute__((packed));
+
+#define F2FS_IOC_SET_ENCRYPTION_POLICY	_IOR('f', 19, struct f2fs_fscrypt_policy)
+#define F2FS_IOC_GET_ENCRYPTION_PWSALT	_IOW('f', 20, __u8[16])
+#define F2FS_IOC_GET_ENCRYPTION_POLICY	_IOW('f', 21, struct f2fs_fscrypt_policy)
+
+typedef int32_t key_serial_t;
+
+
+
+#define OPT_VERBOSE	0x0001
+#define OPT_QUIET	0x0002
+
+struct f2fs_encryption_key {
+        __u32 mode;
+        char raw[F2FS_MAX_KEY_SIZE];
+        __u32 size;
+} __attribute__((__packed__));
+
+int options;
+
+extern void f2fs_sha512(const unsigned char *in, unsigned long in_size,
+						unsigned char *out);
+
+#ifndef HAVE_KEYCTL
+static long keyctl(int cmd, ...)
+{
+	va_list va;
+	unsigned long arg2, arg3, arg4, arg5;
+
+	va_start(va, cmd);
+	arg2 = va_arg(va, unsigned long);
+	arg3 = va_arg(va, unsigned long);
+	arg4 = va_arg(va, unsigned long);
+	arg5 = va_arg(va, unsigned long);
+	va_end(va);
+	return syscall(__NR_keyctl, cmd, arg2, arg3, arg4, arg5);
+}
+#endif
+
+#ifndef HAVE_ADD_KEY
+static key_serial_t add_key(const char *type, const char *description,
+			    const void *payload, size_t plen,
+			    key_serial_t keyring)
+{
+	return syscall(__NR_add_key, type, description, payload,
+		       plen, keyring);
+}
+#endif
+
+static const unsigned char *hexchars = (const unsigned char *) "0123456789abcdef";
+static const size_t hexchars_size = 16;
+
+#define SHA512_LENGTH 64
+#define F2FS_KEY_TYPE_LOGON "logon"
+#define F2FS_KEY_DESC_PREFIX "f2fs:"
+#define F2FS_KEY_DESC_PREFIX_SIZE 5
+
+static int int_log2(int arg)
+{
+	int     l = 0;
+
+	arg >>= 1;
+	while (arg) {
+		l++;
+		arg >>= 1;
+	}
+	return l;
+}
+
+static void validate_paths(int argc, char *argv[], int path_start_index)
+{
+	int x;
+	int valid = 1;
+	struct stat st;
+
+	for (x = path_start_index; x < argc; x++) {
+		int ret = access(argv[x], W_OK);
+		if (ret) {
+		invalid:
+			perror(argv[x]);
+			valid = 0;
+			continue;
+		}
+		ret = stat(argv[x], &st);
+		if (ret < 0)
+			goto invalid;
+		if (!S_ISDIR(st.st_mode)) {
+			fprintf(stderr, "%s is not a directory\n", argv[x]);
+			goto invalid;
+		}
+	}
+	if (!valid)
+		exit(1);
+}
+
+static int hex2byte(const char *hex, size_t hex_size, unsigned char *bytes,
+		    size_t bytes_size)
+{
+	size_t x;
+	unsigned char *h, *l;
+
+	if (hex_size % 2)
+		return -EINVAL;
+	for (x = 0; x < hex_size; x += 2) {
+		h = memchr(hexchars, hex[x], hexchars_size);
+		if (!h)
+			return -EINVAL;
+		l = memchr(hexchars, hex[x + 1], hexchars_size);
+		if (!l)
+			return -EINVAL;
+		if ((x >> 1) >= bytes_size)
+			return -EINVAL;
+		bytes[x >> 1] = (((unsigned char)(h - hexchars) << 4) +
+				 (unsigned char)(l - hexchars));
+	}
+	return 0;
+}
+
+/*
+ * Salt handling
+ */
+struct salt {
+	unsigned char *salt;
+	char key_ref_str[F2FS_KEY_REF_STR_BUF_SIZE];
+	unsigned char key_desc[F2FS_KEY_DESCRIPTOR_SIZE];
+	unsigned char key[F2FS_MAX_KEY_SIZE];
+	size_t salt_len;
+};
+struct salt *salt_list;
+unsigned num_salt;
+unsigned max_salt;
+char in_passphrase[F2FS_MAX_PASSPHRASE_SIZE];
+
+static struct salt *find_by_salt(unsigned char *salt, size_t salt_len)
+{
+	unsigned int i;
+	struct salt *p;
+
+	for (i = 0, p = salt_list; i < num_salt; i++, p++)
+		if ((p->salt_len == salt_len) &&
+		    !memcmp(p->salt, salt, salt_len))
+			return p;
+	return NULL;
+}
+
+static void add_salt(unsigned char *salt, size_t salt_len)
+{
+	if (find_by_salt(salt, salt_len))
+		return;
+	if (num_salt >= max_salt) {
+		max_salt = num_salt + 10;
+		salt_list = realloc(salt_list, max_salt * sizeof(struct salt));
+		if (!salt_list) {
+			fprintf(stderr, "Couldn't allocate salt list\n");
+			exit(1);
+		}
+	}
+	salt_list[num_salt].salt = salt;
+	salt_list[num_salt].salt_len = salt_len;
+	num_salt++;
+}
+
+static void clear_secrets(void)
+{
+	if (salt_list) {
+		memset(salt_list, 0, sizeof(struct salt) * max_salt);
+		free(salt_list);
+		salt_list = NULL;
+	}
+	memset(in_passphrase, 0, sizeof(in_passphrase));
+}
+
+static void die_signal_handler(int signum, siginfo_t *siginfo, void *context)
+{
+	clear_secrets();
+	exit(-1);
+}
+
+static void sigcatcher_setup(void)
+{
+	struct sigaction	sa;
+
+	memset(&sa, 0, sizeof(struct sigaction));
+	sa.sa_sigaction = die_signal_handler;
+	sa.sa_flags = SA_SIGINFO;
+
+	sigaction(SIGHUP, &sa, 0);
+	sigaction(SIGINT, &sa, 0);
+	sigaction(SIGQUIT, &sa, 0);
+	sigaction(SIGFPE, &sa, 0);
+	sigaction(SIGILL, &sa, 0);
+	sigaction(SIGBUS, &sa, 0);
+	sigaction(SIGSEGV, &sa, 0);
+	sigaction(SIGABRT, &sa, 0);
+	sigaction(SIGPIPE, &sa, 0);
+	sigaction(SIGALRM, &sa, 0);
+	sigaction(SIGTERM, &sa, 0);
+	sigaction(SIGUSR1, &sa, 0);
+	sigaction(SIGUSR2, &sa, 0);
+	sigaction(SIGPOLL, &sa, 0);
+	sigaction(SIGPROF, &sa, 0);
+	sigaction(SIGSYS, &sa, 0);
+	sigaction(SIGTRAP, &sa, 0);
+	sigaction(SIGVTALRM, &sa, 0);
+	sigaction(SIGXCPU, &sa, 0);
+	sigaction(SIGXFSZ, &sa, 0);
+}
+
+
+#define PARSE_FLAGS_NOTSUPP_OK	0x0001
+#define PARSE_FLAGS_FORCE_FN	0x0002
+
+static void parse_salt(char *salt_str, int flags)
+{
+	unsigned char buf[F2FS_MAX_SALT_SIZE];
+	char *cp = salt_str;
+	unsigned char *salt_buf;
+	int fd, ret, salt_len = 0;
+
+	if (flags & PARSE_FLAGS_FORCE_FN)
+		goto salt_from_filename;
+	if (strncmp(cp, "s:", 2) == 0) {
+		cp += 2;
+		salt_len = strlen(cp);
+		if (salt_len >= F2FS_MAX_SALT_SIZE)
+			goto invalid_salt;
+		strncpy((char *) buf, cp, sizeof(buf));
+	} else if (cp[0] == '/') {
+	salt_from_filename:
+		fd = open(cp, O_RDONLY | O_DIRECTORY);
+		if (fd == -1 && errno == ENOTDIR)
+			fd = open(cp, O_RDONLY);
+		if (fd == -1) {
+			perror(cp);
+			exit(1);
+		}
+		ret = ioctl(fd, F2FS_IOC_GET_ENCRYPTION_PWSALT, &buf);
+		close(fd);
+		if (ret < 0) {
+			if (flags & PARSE_FLAGS_NOTSUPP_OK)
+				return;
+			perror("F2FS_IOC_GET_ENCRYPTION_PWSALT");
+			exit(1);
+		}
+		if (options & OPT_VERBOSE) {
+			char tmp[80];
+			uuid_unparse(buf, tmp);
+			printf("%s has pw salt %s\n", cp, tmp);
+		}
+		salt_len = 16;
+	} else if (strncmp(cp, "f:", 2) == 0) {
+		cp += 2;
+		goto salt_from_filename;
+	} else if (strncmp(cp, "0x", 2) == 0) {
+		unsigned char *h, *l;
+
+		cp += 2;
+		if (strlen(cp) & 1)
+			goto invalid_salt;
+		while (*cp) {
+			if (salt_len >= F2FS_MAX_SALT_SIZE)
+				goto invalid_salt;
+			h = memchr(hexchars, *cp++, hexchars_size);
+			l = memchr(hexchars, *cp++, hexchars_size);
+			if (!h || !l)
+				goto invalid_salt;
+			buf[salt_len++] =
+				(((unsigned char)(h - hexchars) << 4) +
+				 (unsigned char)(l - hexchars));
+		}
+	} else if (uuid_parse(cp, buf) == 0) {
+		salt_len = 16;
+	} else {
+	invalid_salt:
+		fprintf(stderr, "Invalid salt: %s\n", salt_str);
+		exit(1);
+	}
+	salt_buf = malloc(salt_len);
+	if (!salt_buf) {
+		fprintf(stderr, "Couldn't allocate salt\n");
+		exit(1);
+	}
+	memcpy(salt_buf, buf, salt_len);
+	add_salt(salt_buf, salt_len);
+}
+
+static void set_policy(struct salt *set_salt, int pad,
+		       int argc, char *argv[], int path_start_index)
+{
+	struct salt *salt;
+	struct f2fs_fscrypt_policy policy;
+	uuid_t	uu;
+	int fd;
+	int x;
+	int rc;
+
+	if ((pad != 4) && (pad != 8) &&
+		 (pad != 16) && (pad != 32)) {
+		fprintf(stderr, "Invalid padding %d\n", pad);
+		exit(1);
+	}
+
+	for (x = path_start_index; x < argc; x++) {
+		fd = open(argv[x], O_DIRECTORY);
+		if (fd == -1) {
+			perror(argv[x]);
+			exit(1);
+		}
+		if (set_salt)
+			salt = set_salt;
+		else {
+			if (ioctl(fd, F2FS_IOC_GET_ENCRYPTION_PWSALT,
+				  &uu) < 0) {
+				perror("F2FS_IOC_GET_ENCRYPTION_PWSALT");
+				exit(1);
+			}
+			salt = find_by_salt(uu, sizeof(uu));
+			if (!salt) {
+				fprintf(stderr, "Couldn't find salt!?!\n");
+				exit(1);
+			}
+		}
+		policy.version = 0;
+		policy.contents_encryption_mode =
+			F2FS_ENCRYPTION_MODE_AES_256_XTS;
+		policy.filenames_encryption_mode =
+			F2FS_ENCRYPTION_MODE_AES_256_CTS;
+		policy.flags = int_log2(pad >> 2);
+		memcpy(policy.master_key_descriptor, salt->key_desc,
+		       F2FS_KEY_DESCRIPTOR_SIZE);
+		rc = ioctl(fd, F2FS_IOC_SET_ENCRYPTION_POLICY, &policy);
+		close(fd);
+		if (rc) {
+			printf("Error [%s] setting policy.\nThe key descriptor "
+			       "[%s] may not match the existing encryption "
+			       "context for directory [%s].\n",
+			       strerror(errno), salt->key_ref_str, argv[x]);
+			continue;
+		}
+		printf("Key with descriptor [%s] applied to %s.\n",
+		       salt->key_ref_str, argv[x]);
+	}
+}
+
+static void pbkdf2_sha512(const char *passphrase, struct salt *salt,
+			  unsigned int count,
+			  unsigned char derived_key[F2FS_MAX_KEY_SIZE])
+{
+	size_t passphrase_size = strlen(passphrase);
+	unsigned char buf[SHA512_LENGTH + F2FS_MAX_PASSPHRASE_SIZE] = {0};
+	unsigned char tempbuf[SHA512_LENGTH] = {0};
+	char final[SHA512_LENGTH] = {0};
+	unsigned char saltbuf[F2FS_MAX_SALT_SIZE + F2FS_MAX_PASSPHRASE_SIZE] = {0};
+	int actual_buf_len = SHA512_LENGTH + passphrase_size;
+	int actual_saltbuf_len = F2FS_MAX_SALT_SIZE + passphrase_size;
+	unsigned int x, y;
+	__u32 *final_u32 = (__u32 *)final;
+	__u32 *temp_u32 = (__u32 *)tempbuf;
+
+	if (passphrase_size > F2FS_MAX_PASSPHRASE_SIZE) {
+		printf("Passphrase size is %zd; max is %d.\n", passphrase_size,
+		       F2FS_MAX_PASSPHRASE_SIZE);
+		exit(1);
+	}
+	if (salt->salt_len > F2FS_MAX_SALT_SIZE) {
+		printf("Salt size is %zd; max is %d.\n", salt->salt_len,
+		       F2FS_MAX_SALT_SIZE);
+		exit(1);
+	}
+	assert(F2FS_MAX_KEY_SIZE <= SHA512_LENGTH);
+
+	memcpy(saltbuf, salt->salt, salt->salt_len);
+	memcpy(&saltbuf[F2FS_MAX_SALT_SIZE], passphrase, passphrase_size);
+
+	memcpy(&buf[SHA512_LENGTH], passphrase, passphrase_size);
+
+	for (x = 0; x < count; ++x) {
+		if (x == 0) {
+			f2fs_sha512(saltbuf, actual_saltbuf_len, tempbuf);
+		} else {
+			/*
+			 * buf: [previous hash || passphrase]
+			 */
+			memcpy(buf, tempbuf, SHA512_LENGTH);
+			f2fs_sha512(buf, actual_buf_len, tempbuf);
+		}
+		for (y = 0; y < (sizeof(final) / sizeof(*final_u32)); ++y)
+			final_u32[y] = final_u32[y] ^ temp_u32[y];
+	}
+	memcpy(derived_key, final, F2FS_MAX_KEY_SIZE);
+}
+
+static int disable_echo(struct termios *saved_settings)
+{
+	struct termios current_settings;
+	int rc = 0;
+
+	rc = tcgetattr(0, &current_settings);
+	if (rc)
+		return rc;
+	*saved_settings = current_settings;
+	current_settings.c_lflag &= ~ECHO;
+	rc = tcsetattr(0, TCSANOW, &current_settings);
+
+	return rc;
+}
+
+static void get_passphrase(char *passphrase, int len)
+{
+	char *p;
+	struct termios current_settings;
+
+	assert(len > 0);
+	disable_echo(&current_settings);
+	p = fgets(passphrase, len, stdin);
+	tcsetattr(0, TCSANOW, &current_settings);
+	printf("\n");
+	if (!p) {
+		printf("Aborting.\n");
+		exit(1);
+	}
+	p = strrchr(passphrase, '\n');
+	if (!p)
+		p = passphrase + len - 1;
+	*p = '\0';
+}
+
+struct keyring_map {
+	char name[4];
+	size_t name_len;
+	int code;
+};
+
+static const struct keyring_map keyrings[] = {
+	{"@us", 3, KEY_SPEC_USER_SESSION_KEYRING},
+	{"@u", 2, KEY_SPEC_USER_KEYRING},
+	{"@s", 2, KEY_SPEC_SESSION_KEYRING},
+	{"@g", 2, KEY_SPEC_GROUP_KEYRING},
+	{"@p", 2, KEY_SPEC_PROCESS_KEYRING},
+	{"@t", 2, KEY_SPEC_THREAD_KEYRING},
+};
+
+static int get_keyring_id(const char *keyring)
+{
+	unsigned int x;
+	char *end;
+
+	/*
+	 * If no keyring is specified, by default use either the user
+	 * session key ring or the session keyring.  Fetching the
+	 * session keyring will return the user session keyring if no
+	 * session keyring has been set.
+	 *
+	 * We need to do this instead of simply adding the key to
+	 * KEY_SPEC_SESSION_KEYRING since trying to add a key to a
+	 * session keyring that does not yet exist will cause the
+	 * kernel to create a session keyring --- which wil then get
+	 * garbage collected as soon as f2fscrypt exits.
+	 *
+	 * The fact that the keyctl system call and the add_key system
+	 * call treats KEY_SPEC_SESSION_KEYRING differently when a
+	 * session keyring does not exist is very unfortunate and
+	 * confusing, but so it goes...
+	 */
+	if (keyring == NULL)
+		return keyctl(KEYCTL_GET_KEYRING_ID,
+			      KEY_SPEC_SESSION_KEYRING, 0);
+	for (x = 0; x < (sizeof(keyrings) / sizeof(keyrings[0])); ++x) {
+		if (strcmp(keyring, keyrings[x].name) == 0) {
+			return keyrings[x].code;
+		}
+	}
+	x = strtoul(keyring, &end, 10);
+	if (*end == '\0') {
+		if (keyctl(KEYCTL_DESCRIBE, x, NULL, 0) < 0)
+			return 0;
+		return x;
+	}
+	return 0;
+}
+
+static void generate_key_ref_str(struct salt *salt)
+{
+	unsigned char key_ref1[SHA512_LENGTH];
+	unsigned char key_ref2[SHA512_LENGTH];
+	int x;
+
+	f2fs_sha512(salt->key, F2FS_MAX_KEY_SIZE, key_ref1);
+	f2fs_sha512(key_ref1, SHA512_LENGTH, key_ref2);
+	memcpy(salt->key_desc, key_ref2, F2FS_KEY_DESCRIPTOR_SIZE);
+	for (x = 0; x < F2FS_KEY_DESCRIPTOR_SIZE; ++x) {
+		sprintf(&salt->key_ref_str[x * 2], "%02x",
+			salt->key_desc[x]);
+	}
+	salt->key_ref_str[F2FS_KEY_REF_STR_BUF_SIZE - 1] = '\0';
+}
+
+static void insert_key_into_keyring(const char *keyring, struct salt *salt)
+{
+	int keyring_id = get_keyring_id(keyring);
+	struct f2fs_encryption_key key;
+	char key_ref_full[F2FS_KEY_DESC_PREFIX_SIZE +
+			  F2FS_KEY_REF_STR_BUF_SIZE];
+	int rc;
+
+	if (keyring_id == 0) {
+		printf("Invalid keyring [%s].\n", keyring);
+		exit(1);
+	}
+	sprintf(key_ref_full, "%s%s", F2FS_KEY_DESC_PREFIX,
+		salt->key_ref_str);
+	rc = keyctl(KEYCTL_SEARCH, keyring_id, F2FS_KEY_TYPE_LOGON,
+		    key_ref_full, 0);
+	if (rc != -1) {
+		if ((options & OPT_QUIET) == 0)
+			printf("Key with descriptor [%s] already exists\n",
+			       salt->key_ref_str);
+		return;
+	} else if ((rc == -1) && (errno != ENOKEY)) {
+		printf("keyctl_search failed: %s\n", strerror(errno));
+		if (errno == -EINVAL)
+			printf("Keyring [%s] is not available.\n", keyring);
+		exit(1);
+	}
+	key.mode = F2FS_ENCRYPTION_MODE_AES_256_XTS;
+	memcpy(key.raw, salt->key, F2FS_MAX_KEY_SIZE);
+	key.size = F2FS_MAX_KEY_SIZE;
+	rc = add_key(F2FS_KEY_TYPE_LOGON, key_ref_full, (void *)&key,
+		     sizeof(key), keyring_id);
+	if (rc == -1) {
+		if (errno == EDQUOT) {
+			printf("Error adding key to keyring; quota exceeded\n");
+		} else {
+			printf("Error adding key with key descriptor [%s]: "
+			       "%s\n", salt->key_ref_str, strerror(errno));
+		}
+		exit(1);
+	} else {
+		if ((options & OPT_QUIET) == 0)
+			printf("Added key with descriptor [%s]\n",
+			       salt->key_ref_str);
+	}
+}
+
+static void get_default_salts(void)
+{
+	FILE	*f = setmntent("/etc/mtab", "r");
+	struct mntent *mnt;
+
+	while (f && ((mnt = getmntent(f)) != NULL)) {
+		if (strcmp(mnt->mnt_type, "f2fs") ||
+		    access(mnt->mnt_dir, R_OK))
+			continue;
+		parse_salt(mnt->mnt_dir, PARSE_FLAGS_NOTSUPP_OK);
+	}
+	endmntent(f);
+}
+
+/* Functions which implement user commands */
+
+struct cmd_desc {
+	const char *cmd_name;
+	void (*cmd_func)(int, char **, const struct cmd_desc *);
+	const char *cmd_desc;
+	const char *cmd_help;
+	int cmd_flags;
+};
+
+#define CMD_HIDDEN 	0x0001
+
+static void do_help(int argc, char **argv, const struct cmd_desc *cmd);
+
+#define add_key_desc "adds a key to the user's keyring"
+#define add_key_help \
+"f2fscrypt add_key -S salt [ -k keyring ] [-v] [-q] [ path ... ]\n\n" \
+"Prompts the user for a passphrase and inserts it into the specified\n" \
+"keyring.  If no keyring is specified, f2fscrypt will use the session\n" \
+"keyring if it exists or the user session keyring if it does not.\n\n" \
+"If one or more directory paths are specified, f2fscrypt will try to\n" \
+"set the policy of those directories to use the key just entered by\n" \
+"the user.\n"
+
+static void do_add_key(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	struct salt *salt;
+	char *keyring = NULL;
+	int i, opt, pad = 4;
+	unsigned j;
+
+	while ((opt = getopt(argc, argv, "k:S:p:vq")) != -1) {
+		switch (opt) {
+		case 'k':
+			/* Specify a keyring. */
+			keyring = optarg;
+			break;
+		case 'p':
+			pad = atoi(optarg);
+			break;
+		case 'S':
+			/* Salt value for passphrase. */
+			parse_salt(optarg, 0);
+			break;
+		case 'v':
+			options |= OPT_VERBOSE;
+			break;
+		case 'q':
+			options |= OPT_QUIET;
+			break;
+		default:
+			fprintf(stderr, "Unrecognized option: %c\n", opt);
+		case '?':
+			fputs("USAGE:\n  ", stderr);
+			fputs(cmd->cmd_help, stderr);
+			exit(1);
+		}
+	}
+	if (num_salt == 0)
+		get_default_salts();
+	if (num_salt == 0) {
+		fprintf(stderr, "No salt values available\n");
+		exit(1);
+	}
+	validate_paths(argc, argv, optind);
+	for (i = optind; i < argc; i++)
+		parse_salt(argv[i], PARSE_FLAGS_FORCE_FN);
+	printf("Enter passphrase (echo disabled): ");
+	get_passphrase(in_passphrase, sizeof(in_passphrase));
+	for (j = 0, salt = salt_list; j < num_salt; j++, salt++) {
+		pbkdf2_sha512(in_passphrase, salt,
+			      F2FS_PBKDF2_ITERATIONS, salt->key);
+		generate_key_ref_str(salt);
+		insert_key_into_keyring(keyring, salt);
+	}
+	if (optind != argc)
+		set_policy(NULL, pad, argc, argv, optind);
+	clear_secrets();
+	exit(0);
+}
+
+#define set_policy_desc "sets a policy for directories"
+#define set_policy_help \
+"f2fscrypt set_policy policy path ... \n\n" \
+"Sets the policy for the directories specified on the command line.\n" \
+"All directories must be empty to set the policy; if the directory\n" \
+"already has a policy established, f2fscrypt will validate that it the\n" \
+"policy matches what was specified.  A policy is an encryption key\n" \
+"identifier consisting of 16 hexadecimal characters.\n"
+
+static void do_set_policy(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	struct salt saltbuf;
+	int c, pad = 4;
+
+	while ((c = getopt (argc, argv, "p:")) != EOF) {
+		switch (c) {
+		case 'p':
+			pad = atoi(optarg);
+			break;
+		}
+	}
+
+	if (argc < optind + 2) {
+		fprintf(stderr, "Missing required argument(s).\n\n");
+		fputs("USAGE:\n  ", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	if ((strlen(argv[optind]) != (F2FS_KEY_DESCRIPTOR_SIZE * 2)) ||
+	    hex2byte(argv[optind], (F2FS_KEY_DESCRIPTOR_SIZE * 2),
+		     saltbuf.key_desc, F2FS_KEY_DESCRIPTOR_SIZE)) {
+		printf("Invalid key descriptor [%s]. Valid characters "
+		       "are 0-9 and a-f, lower case.  "
+		       "Length must be %d.\n",
+		       argv[optind], (F2FS_KEY_DESCRIPTOR_SIZE * 2));
+			exit(1);
+	}
+	validate_paths(argc, argv, optind+1);
+	strcpy(saltbuf.key_ref_str, argv[optind]);
+	set_policy(&saltbuf, pad, argc, argv, optind+1);
+	exit(0);
+}
+
+#define get_policy_desc "get the encryption for directories"
+#define get_policy_help \
+"f2fscrypt get_policy path ... \n\n" \
+"Gets the policy for the directories specified on the command line.\n"
+
+static void do_get_policy(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	struct f2fs_fscrypt_policy policy;
+	struct stat st;
+	int i, j, fd, rc;
+
+	if (argc < 2) {
+		fprintf(stderr, "Missing required argument(s).\n\n");
+		fputs("USAGE:\n  ", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	for (i = 1; i < argc; i++) {
+		if (stat(argv[i], &st) < 0) {
+			perror(argv[i]);
+			continue;
+		}
+		fd = open(argv[i],
+			  S_ISDIR(st.st_mode) ? O_DIRECTORY : O_RDONLY);
+		if (fd == -1) {
+			perror(argv[i]);
+			exit(1);
+		}
+		rc = ioctl(fd, F2FS_IOC_GET_ENCRYPTION_POLICY, &policy);
+		close(fd);
+		if (rc) {
+			printf("Error getting policy for %s: %s\n",
+			       argv[i], strerror(errno));
+			continue;
+		}
+		printf("%s: ", argv[i]);
+		for (j = 0; j < F2FS_KEY_DESCRIPTOR_SIZE; j++) {
+			printf("%02x", (unsigned char) policy.master_key_descriptor[j]);
+		}
+		fputc('\n', stdout);
+	}
+	exit(0);
+}
+
+#define new_session_desc "give the invoking process a new session keyring"
+#define new_session_help \
+"f2fscrypt new_session\n\n" \
+"Give the invoking process (typically a shell) a new session keyring,\n" \
+"discarding its old session keyring.\n"
+
+static void do_new_session(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	long keyid, ret;
+
+	if (argc > 1) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+	keyid = keyctl(KEYCTL_JOIN_SESSION_KEYRING, NULL);
+	if (keyid < 0) {
+		perror("KEYCTL_JOIN_SESSION_KEYRING");
+		exit(1);
+	}
+	ret = keyctl(KEYCTL_SESSION_TO_PARENT, NULL);
+	if (ret < 0) {
+		perror("KEYCTL_SESSION_TO_PARENT");
+		exit(1);
+	}
+	printf("Switched invoking process to new session keyring %ld\n", keyid);
+	exit(0);
+}
+
+#define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
+#define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
+
+const struct cmd_desc cmd_list[] = {
+	_CMD(help),
+	CMD(add_key),
+	CMD(get_policy),
+	CMD(new_session),
+	CMD(set_policy),
+	{ NULL, NULL, NULL, NULL, 0 }
+};
+
+static void do_help(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	const struct cmd_desc *p;
+
+	if (argc > 1) {
+		for (p = cmd_list; p->cmd_name; p++) {
+			if (p->cmd_flags & CMD_HIDDEN)
+				continue;
+			if (strcmp(p->cmd_name, argv[1]) == 0) {
+				putc('\n', stdout);
+				fputs("USAGE:\n  ", stdout);
+				fputs(p->cmd_help, stdout);
+				exit(0);
+			}
+		}
+		printf("Unknown command: %s\n\n", argv[1]);
+	}
+
+	fputs("Available commands:\n", stdout);
+	for (p = cmd_list; p->cmd_name; p++) {
+		if (p->cmd_flags & CMD_HIDDEN)
+			continue;
+		printf("  %-20s %s\n", p->cmd_name, p->cmd_desc);
+	}
+	printf("\nTo get more information on a command, "
+	       "type 'f2fscrypt help cmd'\n");
+	exit(0);
+}
+
+int main(int argc, char *argv[])
+{
+	const struct cmd_desc *cmd;
+
+	if (argc < 2)
+		do_help(argc, argv, cmd_list);
+
+	sigcatcher_setup();
+	for (cmd = cmd_list; cmd->cmd_name; cmd++) {
+		if (strcmp(cmd->cmd_name, argv[1]) == 0) {
+			cmd->cmd_func(argc-1, argv+1, cmd);
+			exit(0);
+		}
+	}
+	printf("Unknown command: %s\n\n", argv[1]);
+	do_help(1, argv, cmd_list);
+	return 0;
+}
diff --git a/tools/sha512.c b/tools/sha512.c
new file mode 100644
index 0000000..bf0d9a4
--- /dev/null
+++ b/tools/sha512.c
@@ -0,0 +1,323 @@
+/*
+ * sha512.c --- The sha512 algorithm
+ *
+ * Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
+ * (copied from libtomcrypt and then relicensed under GPLv2)
+ *
+ * %Begin-Header%
+ * This file may be redistributed under the terms of the GNU Library
+ * General Public License, version 2.
+ * %End-Header%
+ */
+
+
+#include "config.h"
+#include <assert.h>
+#include <errno.h>
+#include <getopt.h>
+#include <dirent.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <mntent.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <termios.h>
+#include <unistd.h>
+#include <signal.h>
+#include <linux/fs.h>
+
+#if HAVE_SYS_TYPES_H
+#include <sys/types.h>
+#endif
+
+#define F2FS_SHA512_LENGTH 64
+
+/* the K array */
+#define CONST64(n) n
+static const __u64 K[80] = {
+	CONST64(0x428a2f98d728ae22), CONST64(0x7137449123ef65cd),
+	CONST64(0xb5c0fbcfec4d3b2f), CONST64(0xe9b5dba58189dbbc),
+	CONST64(0x3956c25bf348b538), CONST64(0x59f111f1b605d019),
+	CONST64(0x923f82a4af194f9b), CONST64(0xab1c5ed5da6d8118),
+	CONST64(0xd807aa98a3030242), CONST64(0x12835b0145706fbe),
+	CONST64(0x243185be4ee4b28c), CONST64(0x550c7dc3d5ffb4e2),
+	CONST64(0x72be5d74f27b896f), CONST64(0x80deb1fe3b1696b1),
+	CONST64(0x9bdc06a725c71235), CONST64(0xc19bf174cf692694),
+	CONST64(0xe49b69c19ef14ad2), CONST64(0xefbe4786384f25e3),
+	CONST64(0x0fc19dc68b8cd5b5), CONST64(0x240ca1cc77ac9c65),
+	CONST64(0x2de92c6f592b0275), CONST64(0x4a7484aa6ea6e483),
+	CONST64(0x5cb0a9dcbd41fbd4), CONST64(0x76f988da831153b5),
+	CONST64(0x983e5152ee66dfab), CONST64(0xa831c66d2db43210),
+	CONST64(0xb00327c898fb213f), CONST64(0xbf597fc7beef0ee4),
+	CONST64(0xc6e00bf33da88fc2), CONST64(0xd5a79147930aa725),
+	CONST64(0x06ca6351e003826f), CONST64(0x142929670a0e6e70),
+	CONST64(0x27b70a8546d22ffc), CONST64(0x2e1b21385c26c926),
+	CONST64(0x4d2c6dfc5ac42aed), CONST64(0x53380d139d95b3df),
+	CONST64(0x650a73548baf63de), CONST64(0x766a0abb3c77b2a8),
+	CONST64(0x81c2c92e47edaee6), CONST64(0x92722c851482353b),
+	CONST64(0xa2bfe8a14cf10364), CONST64(0xa81a664bbc423001),
+	CONST64(0xc24b8b70d0f89791), CONST64(0xc76c51a30654be30),
+	CONST64(0xd192e819d6ef5218), CONST64(0xd69906245565a910),
+	CONST64(0xf40e35855771202a), CONST64(0x106aa07032bbd1b8),
+	CONST64(0x19a4c116b8d2d0c8), CONST64(0x1e376c085141ab53),
+	CONST64(0x2748774cdf8eeb99), CONST64(0x34b0bcb5e19b48a8),
+	CONST64(0x391c0cb3c5c95a63), CONST64(0x4ed8aa4ae3418acb),
+	CONST64(0x5b9cca4f7763e373), CONST64(0x682e6ff3d6b2b8a3),
+	CONST64(0x748f82ee5defb2fc), CONST64(0x78a5636f43172f60),
+	CONST64(0x84c87814a1f0ab72), CONST64(0x8cc702081a6439ec),
+	CONST64(0x90befffa23631e28), CONST64(0xa4506cebde82bde9),
+	CONST64(0xbef9a3f7b2c67915), CONST64(0xc67178f2e372532b),
+	CONST64(0xca273eceea26619c), CONST64(0xd186b8c721c0c207),
+	CONST64(0xeada7dd6cde0eb1e), CONST64(0xf57d4f7fee6ed178),
+	CONST64(0x06f067aa72176fba), CONST64(0x0a637dc5a2c898a6),
+	CONST64(0x113f9804bef90dae), CONST64(0x1b710b35131c471b),
+	CONST64(0x28db77f523047d84), CONST64(0x32caab7b40c72493),
+	CONST64(0x3c9ebe0a15c9bebc), CONST64(0x431d67c49c100d4c),
+	CONST64(0x4cc5d4becb3e42b6), CONST64(0x597f299cfc657e2a),
+	CONST64(0x5fcb6fab3ad6faec), CONST64(0x6c44198c4a475817)
+};
+#define Ch(x,y,z)       (z ^ (x & (y ^ z)))
+#define Maj(x,y,z)      (((x | y) & z) | (x & y))
+#define S(x, n)         ROR64c(x, n)
+#define R(x, n)         (((x)&CONST64(0xFFFFFFFFFFFFFFFF))>>((__u64)n))
+#define Sigma0(x)       (S(x, 28) ^ S(x, 34) ^ S(x, 39))
+#define Sigma1(x)       (S(x, 14) ^ S(x, 18) ^ S(x, 41))
+#define Gamma0(x)       (S(x, 1) ^ S(x, 8) ^ R(x, 7))
+#define Gamma1(x)       (S(x, 19) ^ S(x, 61) ^ R(x, 6))
+#define RND(a,b,c,d,e,f,g,h,i)\
+		t0 = h + Sigma1(e) + Ch(e, f, g) + K[i] + W[i];\
+		t1 = Sigma0(a) + Maj(a, b, c);\
+		d += t0;\
+		h  = t0 + t1;
+#define STORE64H(x, y) \
+	do { \
+		(y)[0] = (unsigned char)(((x)>>56)&255);\
+		(y)[1] = (unsigned char)(((x)>>48)&255);\
+		(y)[2] = (unsigned char)(((x)>>40)&255);\
+		(y)[3] = (unsigned char)(((x)>>32)&255);\
+		(y)[4] = (unsigned char)(((x)>>24)&255);\
+		(y)[5] = (unsigned char)(((x)>>16)&255);\
+		(y)[6] = (unsigned char)(((x)>>8)&255);\
+		(y)[7] = (unsigned char)((x)&255); } while(0)
+
+#define LOAD64H(x, y)\
+	do {x = \
+		(((__u64)((y)[0] & 255)) << 56) |\
+		(((__u64)((y)[1] & 255)) << 48) |\
+		(((__u64)((y)[2] & 255)) << 40) |\
+		(((__u64)((y)[3] & 255)) << 32) |\
+		(((__u64)((y)[4] & 255)) << 24) |\
+		(((__u64)((y)[5] & 255)) << 16) |\
+		(((__u64)((y)[6] & 255)) << 8) |\
+		(((__u64)((y)[7] & 255)));\
+	} while(0)
+
+#define ROR64c(x, y) \
+    ( ((((x)&CONST64(0xFFFFFFFFFFFFFFFF))>>((__u64)(y)&CONST64(63))) | \
+      ((x)<<((__u64)(64-((y)&CONST64(63)))))) & CONST64(0xFFFFFFFFFFFFFFFF))
+
+struct sha512_state {
+	__u64  length, state[8];
+	unsigned long curlen;
+	unsigned char buf[128];
+};
+
+/* This is a highly simplified version from libtomcrypt */
+struct hash_state {
+	struct sha512_state sha512;
+};
+
+static void sha512_compress(struct hash_state * md, const unsigned char *buf)
+{
+	__u64 S[8], W[80], t0, t1;
+	int i;
+
+	/* copy state into S */
+	for (i = 0; i < 8; i++) {
+		S[i] = md->sha512.state[i];
+	}
+
+	/* copy the state into 1024-bits into W[0..15] */
+	for (i = 0; i < 16; i++) {
+		LOAD64H(W[i], buf + (8*i));
+	}
+
+	/* fill W[16..79] */
+	for (i = 16; i < 80; i++) {
+		W[i] = Gamma1(W[i - 2]) + W[i - 7] +
+			Gamma0(W[i - 15]) + W[i - 16];
+	}
+
+	for (i = 0; i < 80; i += 8) {
+		RND(S[0],S[1],S[2],S[3],S[4],S[5],S[6],S[7],i+0);
+		RND(S[7],S[0],S[1],S[2],S[3],S[4],S[5],S[6],i+1);
+		RND(S[6],S[7],S[0],S[1],S[2],S[3],S[4],S[5],i+2);
+		RND(S[5],S[6],S[7],S[0],S[1],S[2],S[3],S[4],i+3);
+		RND(S[4],S[5],S[6],S[7],S[0],S[1],S[2],S[3],i+4);
+		RND(S[3],S[4],S[5],S[6],S[7],S[0],S[1],S[2],i+5);
+		RND(S[2],S[3],S[4],S[5],S[6],S[7],S[0],S[1],i+6);
+		RND(S[1],S[2],S[3],S[4],S[5],S[6],S[7],S[0],i+7);
+	}
+
+	 /* feedback */
+	for (i = 0; i < 8; i++) {
+		md->sha512.state[i] = md->sha512.state[i] + S[i];
+	}
+}
+
+static void sha512_init(struct hash_state * md)
+{
+	md->sha512.curlen = 0;
+	md->sha512.length = 0;
+	md->sha512.state[0] = CONST64(0x6a09e667f3bcc908);
+	md->sha512.state[1] = CONST64(0xbb67ae8584caa73b);
+	md->sha512.state[2] = CONST64(0x3c6ef372fe94f82b);
+	md->sha512.state[3] = CONST64(0xa54ff53a5f1d36f1);
+	md->sha512.state[4] = CONST64(0x510e527fade682d1);
+	md->sha512.state[5] = CONST64(0x9b05688c2b3e6c1f);
+	md->sha512.state[6] = CONST64(0x1f83d9abfb41bd6b);
+	md->sha512.state[7] = CONST64(0x5be0cd19137e2179);
+}
+
+static void sha512_done(struct hash_state * md, unsigned char *out)
+{
+	int i;
+
+	/* increase the length of the message */
+	md->sha512.length += md->sha512.curlen * CONST64(8);
+
+	/* append the '1' bit */
+	md->sha512.buf[md->sha512.curlen++] = (unsigned char)0x80;
+
+	/* if the length is currently above 112 bytes we append zeros then
+	 * compress. Then we can fall back to padding zeros and length encoding
+	 * like normal. */
+	if (md->sha512.curlen > 112) {
+		while (md->sha512.curlen < 128) {
+			md->sha512.buf[md->sha512.curlen++] = (unsigned char)0;
+		}
+		sha512_compress(md, md->sha512.buf);
+		md->sha512.curlen = 0;
+	}
+
+	/* pad upto 120 bytes of zeroes note: that from 112 to 120 is the 64 MSB
+	 * of the length. We assume that you won't hash > 2^64 bits of data. */
+	while (md->sha512.curlen < 120) {
+		md->sha512.buf[md->sha512.curlen++] = (unsigned char)0;
+	}
+
+	/* store length */
+	STORE64H(md->sha512.length, md->sha512.buf + 120);
+	sha512_compress(md, md->sha512.buf);
+
+	/* copy output */
+	for (i = 0; i < 8; i++) {
+		STORE64H(md->sha512.state[i], out+(8 * i));
+	}
+}
+
+#define MIN(x, y) ( ((x)<(y))?(x):(y) )
+#define SHA512_BLOCKSIZE 128
+static void sha512_process(struct hash_state * md,
+			   const unsigned char *in,
+			   unsigned long inlen)
+{
+	unsigned long n;
+
+	while (inlen > 0) {
+		if (md->sha512.curlen == 0 && inlen >= SHA512_BLOCKSIZE) {
+			sha512_compress(md, in);
+			md->sha512.length += SHA512_BLOCKSIZE * 8;
+			in += SHA512_BLOCKSIZE;
+			inlen -= SHA512_BLOCKSIZE;
+		} else {
+			n = MIN(inlen, (SHA512_BLOCKSIZE - md->sha512.curlen));
+			memcpy(md->sha512.buf + md->sha512.curlen,
+			       in, (size_t)n);
+			md->sha512.curlen += n;
+			in += n;
+			inlen -= n;
+			if (md->sha512.curlen == SHA512_BLOCKSIZE) {
+				sha512_compress(md, md->sha512.buf);
+				md->sha512.length += SHA512_BLOCKSIZE * 8;
+				md->sha512.curlen = 0;
+			}
+		}
+	}
+}
+
+void f2fs_sha512(const unsigned char *in, unsigned long in_size,
+		   unsigned char out[F2FS_SHA512_LENGTH])
+{
+	struct hash_state md;
+
+	sha512_init(&md);
+	sha512_process(&md, in, in_size);
+	sha512_done(&md, out);
+}
+
+#ifdef UNITTEST
+static const struct {
+	char *msg;
+	unsigned char hash[64];
+} tests[] = {
+	{ "",
+	  { 0xcf, 0x83, 0xe1, 0x35, 0x7e, 0xef, 0xb8, 0xbd,
+	    0xf1, 0x54, 0x28, 0x50, 0xd6, 0x6d, 0x80, 0x07,
+	    0xd6, 0x20, 0xe4, 0x05, 0x0b, 0x57, 0x15, 0xdc,
+	    0x83, 0xf4, 0xa9, 0x21, 0xd3, 0x6c, 0xe9, 0xce,
+	    0x47, 0xd0, 0xd1, 0x3c, 0x5d, 0x85, 0xf2, 0xb0,
+	    0xff, 0x83, 0x18, 0xd2, 0x87, 0x7e, 0xec, 0x2f,
+	    0x63, 0xb9, 0x31, 0xbd, 0x47, 0x41, 0x7a, 0x81,
+	    0xa5, 0x38, 0x32, 0x7a, 0xf9, 0x27, 0xda, 0x3e }
+	},
+	{ "abc",
+	  { 0xdd, 0xaf, 0x35, 0xa1, 0x93, 0x61, 0x7a, 0xba,
+	    0xcc, 0x41, 0x73, 0x49, 0xae, 0x20, 0x41, 0x31,
+	    0x12, 0xe6, 0xfa, 0x4e, 0x89, 0xa9, 0x7e, 0xa2,
+	    0x0a, 0x9e, 0xee, 0xe6, 0x4b, 0x55, 0xd3, 0x9a,
+	    0x21, 0x92, 0x99, 0x2a, 0x27, 0x4f, 0xc1, 0xa8,
+	    0x36, 0xba, 0x3c, 0x23, 0xa3, 0xfe, 0xeb, 0xbd,
+	    0x45, 0x4d, 0x44, 0x23, 0x64, 0x3c, 0xe8, 0x0e,
+	    0x2a, 0x9a, 0xc9, 0x4f, 0xa5, 0x4c, 0xa4, 0x9f }
+	},
+	{ "abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmnhijklmnoijklmnopjklmnopqklmnopqrlmnopqrsmnopqrstnopqrstu",
+	  { 0x8e, 0x95, 0x9b, 0x75, 0xda, 0xe3, 0x13, 0xda,
+	    0x8c, 0xf4, 0xf7, 0x28, 0x14, 0xfc, 0x14, 0x3f,
+	    0x8f, 0x77, 0x79, 0xc6, 0xeb, 0x9f, 0x7f, 0xa1,
+	    0x72, 0x99, 0xae, 0xad, 0xb6, 0x88, 0x90, 0x18,
+	    0x50, 0x1d, 0x28, 0x9e, 0x49, 0x00, 0xf7, 0xe4,
+	    0x33, 0x1b, 0x99, 0xde, 0xc4, 0xb5, 0x43, 0x3a,
+	    0xc7, 0xd3, 0x29, 0xee, 0xb6, 0xdd, 0x26, 0x54,
+	    0x5e, 0x96, 0xe5, 0x5b, 0x87, 0x4b, 0xe9, 0x09 }
+	},
+};
+
+int main(int argc, char **argv)
+{
+	int i;
+	int errors = 0;
+	unsigned char tmp[64];
+	struct hash_state md;
+
+	for (i = 0; i < (int)(sizeof(tests) / sizeof(tests[0])); i++) {
+		unsigned char *msg = (unsigned char *) tests[i].msg;
+		int len = strlen(tests[i].msg);
+
+		f2fs_sha512(msg, len, tmp);
+		printf("SHA512 test message %d: ", i);
+		if (memcmp(tmp, tests[i].hash, 64) != 0) {
+			printf("FAILED\n");
+			errors++;
+		} else
+			printf("OK\n");
+	}
+	return errors;
+}
+
+#endif /* UNITTEST */
-- 
2.9.3


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
