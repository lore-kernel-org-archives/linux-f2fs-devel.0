From: Wang Shilong via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Subject: =?gb2312?b?u9i4tDogu9i4tDogIFtQQVRDSCAxLzJdIGV4dDQ6?=
 =?gb2312?b?IG9ubHkgc2V0IHByb2plY3QgaW5oZXJpdCBiaXQgZm9yIGRpcmVjdG9yeQ==?=
Date: Sat, 8 Jun 2019 01:15:00 +0000
Message-ID: <MN2PR19MB316710380735D81840557886D4110@MN2PR19MB3167.namprd19.prod.outlook.com>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
 <20190606224525.GB84833@gmail.com>
 <MN2PR19MB3167ED3E8C9C85AE510F7BF4D4100@MN2PR19MB3167.namprd19.prod.outlook.com>,
 <20190607181452.GC648@sol.localdomain>
Reply-To: Wang Shilong <wshilong@ddn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wshilong@ddn.com>) id 1hZPwu-0002BV-89
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 08 Jun 2019 01:15:12 +0000
Received: from mail-eopbgr700054.outbound.protection.outlook.com
 ([40.107.70.54] helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1hZPwr-000nFl-1X
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 08 Jun 2019 01:15:12 +0000
In-Reply-To: <20190607181452.GC648@sol.localdomain>
Content-Language: zh-CN
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
Cc: Andreas Dilger <adilger@dilger.ca>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Wang Shilong <wangshilong1991@gmail.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi,


> You are right for this and we also need take care of this in EXT4_IOC_FSSETXATTR/
> this is a bit strange behavior as chattr read existed flags
> but could not set them again, there are several possible ways that I could think
> of to fix the issue?
>
> 1) change chattr to filter Project inherit bit before call FS_IOC_SETFLAGS
>
> 2) we automatically fixed the flag before mask check, something like:
> if reg:
>      flags &= ~PROJECT_INHERT;
>       if (ext4_mask_flags(inode->i_mode, flags) != flags)
>                 return -EOPNOTSUPP;
> But this might be not good..
>
> I would prefer solution 1)
> What do you think?

Existing versions of chattr can't be changed, and people don't necessarily
upgrade the kernel and e2fsprogs at the same time.  So (1) wouldn't really work.

A better solution might be to make FS_IOC_GETFLAGS and FS_IOC_FSGETXATTR never
return the project inherit flag on regular files.

- Eric

>>>>>>

How about fix it in  __ext4_iget():

  ei->i_flags = le32_to_cpu(raw_inode->i_flags);
  if (S_ISREG(inode->i_mode))
       ei->i_flags &= ~EXT4_PROJINHERIT_FL;

This way will give a big chance flag will be automatically fixed
next time whenever inode is dirtied.

Thanks,
Shilong
