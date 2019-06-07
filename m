From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: =?utf-8?b?5Zue5aSNOiAgW1BBVENIIDEvMl0gZXh0NDogb25s?=
 =?utf-8?q?y_set_project_inherit_bit_for_directory?=
Date: Fri, 7 Jun 2019 11:14:52 -0700
Message-ID: <20190607181452.GC648@sol.localdomain>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
 <20190606224525.GB84833@gmail.com>
 <MN2PR19MB3167ED3E8C9C85AE510F7BF4D4100@MN2PR19MB3167.namprd19.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hZJOP-0007Bg-OO
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 07 Jun 2019 18:15:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hZJOH-009VEj-Bi
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 07 Jun 2019 18:15:05 +0000
Content-Disposition: inline
In-Reply-To: <MN2PR19MB3167ED3E8C9C85AE510F7BF4D4100@MN2PR19MB3167.namprd19.prod.outlook.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Wang Shilong <wshilong@ddn.com>
Cc: Andreas Dilger <adilger@dilger.ca>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Wang Shilong <wangshilong1991@gmail.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

On Fri, Jun 07, 2019 at 07:51:18AM +0000, Wang Shilong wrote:
> Hi,
> =

> > --
> > 2.21.0
> =

> Won't this break 'chattr' on files that already have this flag set?
> FS_IOC_GETFLAGS will return this flag, so 'chattr' will pass it back to
> FS_IOC_SETFLAGS which will return EOPNOTSUPP due to this:
> =

> =A0 =A0 =A0 =A0 if (ext4_mask_flags(inode->i_mode, flags) !=3D flags)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
> =

> >>>>
> =

> You are right for this and we also need take care of this in EXT4_IOC_FSS=
ETXATTR/
> this is a bit strange behavior as chattr read existed flags
> but could not set them again, there are several possible ways that I coul=
d think
> of to fix the issue?
> =

> 1) change chattr to filter Project inherit bit before call FS_IOC_SETFLAGS
> =

> 2) we automatically fixed the flag before mask check, something like:
> if reg:
>      flags &=3D ~PROJECT_INHERT;
>       if (ext4_mask_flags(inode->i_mode, flags) !=3D flags)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
> But this might be not good..
> =

> I would prefer solution 1)
> What do you think?

Existing versions of chattr can't be changed, and people don't necessarily
upgrade the kernel and e2fsprogs at the same time.  So (1) wouldn't really =
work.

A better solution might be to make FS_IOC_GETFLAGS and FS_IOC_FSGETXATTR ne=
ver
return the project inherit flag on regular files.

- Eric
