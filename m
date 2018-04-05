From: Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [PATCH] f2fs: fix to show encrypt flag in FS_IOC_GETFLAGS
Date: Thu, 5 Apr 2018 01:34:11 +0000
Message-ID: <DM5PR2101MB1032B1052D6E502C1D54194CFBBB0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <20180402102446.32832-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180402102446.32832-1-yuchao0@huawei.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Sasha Levin <Alexander.Levin@microsoft.com>, Chao Yu <yuchao0@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao Yu.

[This is an automated email]

This commit has been processed by the -stable helper bot and determined
to be a high probability candidate for -stable trees. (score: 11.4088)

The bot has tested the following trees: v4.15.15, v4.14.32, v4.9.92, v4.4.1=
26,=20

v4.15.15: Build OK!
v4.14.32: Build OK!
v4.9.92: Failed to apply! Possible dependencies:
    2c1d03056991: ("f2fs: support F2FS_IOC_FS{GET,SET}XATTR")
    34dc77ad7436: ("f2fs: add ioctl to do gc with target block address")
    e066b83c9b40: ("f2fs: add ioctl to flush data from faster device to col=
d area")
    cac5a3d8f517: ("f2fs: fix 446 coding style warnings in f2fs.h")
    7c45729a4d6d: ("f2fs: keep dirty inodes selectively for checkpoint")
    15d04354555f: ("f2fs: call f2fs_balance_fs for setattr")

v4.4.126: Failed to apply! Possible dependencies:
    2c1d03056991: ("f2fs: support F2FS_IOC_FS{GET,SET}XATTR")
    34dc77ad7436: ("f2fs: add ioctl to do gc with target block address")
    e066b83c9b40: ("f2fs: add ioctl to flush data from faster device to col=
d area")
    4dd6f977fc77: ("f2fs: support an ioctl to move a range of data blocks")
    d323d005ac4a: ("f2fs: support file defragment")
    8da4b8c48e7b: ("lib/uuid.c: move generate_random_uuid() to uuid.c")
    9b7365fc1c82: ("ext4: add FS_IOC_FSSETXATTR/FS_IOC_FSGETXATTR interface=
 support")


Please let us know if you'd like to have this patch included in a stable tr=
ee.
