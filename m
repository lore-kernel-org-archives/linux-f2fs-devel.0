From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 0/7] f2fs-tools: zoned block device support
Date: Mon, 31 Oct 2016 20:46:18 -0700
Message-ID: <20161101034618.GA30731@jaegeuk>
References: <1477641424-12367-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c1Q1v-0002JF-Jw
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Nov 2016 03:46:31 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c1Q1t-0003mr-9x
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Nov 2016 03:46:31 +0000
Content-Disposition: inline
In-Reply-To: <1477641424-12367-1-git-send-email-damien.lemoal@wdc.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>, linux-f2fs-devel@lists.sourceforge.net

Hi Damien,

I've resolved some conflicts in the patches, and finally integrated them on
top of our dev branch.
Could you take a look at them from the below url?

http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git/log/?h=dev

Thanks,

On Fri, Oct 28, 2016 at 04:56:56PM +0900, Damien Le Moal wrote:
> With the introduction of zoned block device support in the kernel, accessing
> discovering if a block device is zoned and accessing its zone layout information
> does not require using SG_IO anymore. The file /sys/block/<dev>/queue/zoned
> indicates the device zone model and the ioctls BLKREPORTZONE and BLKRESETZONE
> defined in include/uapi/linux/blkzoned.h allow manipulating zones more easily.
> 
> This patch series brings in support for this new interface in place of the
> direct SG_IO-zbc commands. In addition, it enforces some formtating options
> for host-managed zoned block devices and straighten device zone layout checks
> to make sure that the device can be used.
> 
> Finally, as discard does not result in write pointer zone reset, the ioctl
> BLKRESETZONE is used during formatting to properly initialize all sequential
> zones of the device.
> 
> Damien Le Moal (7):
>   f2fs-tools: Add executable files to .gitignore
>   f2fs-tools: Use zoned block device terminology
>   f2fs-tools: Introduce support for zoned block devices
>   mkfs.f2fs: Check options for zoned block devices
>   mkfs.f2fs: Reset sequential zones on device discard
>   mkfs.f2fs: Check zoned block devices configuration
>   fsck.f2fs: Check BLKZONED feature on mount
> 
>  .gitignore               |   4 +
>  configure.ac             |   2 +-
>  fsck/mount.c             |  11 +-
>  include/f2fs_fs.h        | 111 +++++---
>  lib/Makefile.am          |   2 +-
>  lib/libf2fs.c            |  40 ++-
>  lib/libf2fs_zoned.c      | 296 ++++++++++++++++++++++
>  lib/zbc.c                | 647 -----------------------------------------------
>  lib/zbc.h                | 361 --------------------------
>  mkfs/f2fs_format.c       |  24 +-
>  mkfs/f2fs_format_main.c  |  24 +-
>  mkfs/f2fs_format_utils.c |   2 +
>  12 files changed, 464 insertions(+), 1060 deletions(-)
>  create mode 100644 lib/libf2fs_zoned.c
>  delete mode 100644 lib/zbc.c
>  delete mode 100644 lib/zbc.h
> 
> -- 
> 2.7.4
> 
> Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:
> 
> This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.

------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
