From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: =?utf-8?b?5Zue5aSNOiAgW1BBVENIIDEvMl0gZXh0NDogb25s?=
 =?utf-8?q?y_set_project_inherit_bit_for_directory?=
Date: Mon, 10 Jun 2019 00:38:28 -0400
Message-ID: <20190610043828.GC15963@mit.edu>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
 <20190606224525.GB84833@gmail.com>
 <MN2PR19MB3167ED3E8C9C85AE510F7BF4D4100@MN2PR19MB3167.namprd19.prod.outlook.com>
 <20190607181452.GC648@sol.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1haC50-0002qw-9i
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jun 2019 04:38:46 +0000
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1haC4y-005VhL-Pp
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jun 2019 04:38:46 +0000
Content-Disposition: inline
In-Reply-To: <20190607181452.GC648@sol.localdomain>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andreas Dilger <adilger@dilger.ca>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Wang Shilong <wangshilong1991@gmail.com>, Wang Shilong <wshilong@ddn.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

On Fri, Jun 07, 2019 at 11:14:52AM -0700, Eric Biggers wrote:
> 
> Existing versions of chattr can't be changed, and people don't necessarily
> upgrade the kernel and e2fsprogs at the same time.  So (1) wouldn't really work.
> 
> A better solution might be to make FS_IOC_GETFLAGS and FS_IOC_FSGETXATTR never
> return the project inherit flag on regular files.

I've amended this patch by adding the following to fix it for
FS_IOC_GETFLAGS (which is chattr uses):

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7af835ac8d23..74648d42c69b 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -779,6 +779,8 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return ext4_ioc_getfsmap(sb, (void __user *)arg);
 	case EXT4_IOC_GETFLAGS:
 		flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
+		if (S_ISREG(inode->i_mode))
+			flags &= ~EXT4_PROJINHERIT_FL;
 		return put_user(flags, (int __user *) arg);
 	case EXT4_IOC_SETFLAGS: {
 		int err;

						- Ted
