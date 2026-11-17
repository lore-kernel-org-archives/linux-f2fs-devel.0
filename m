Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B78606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=J6qPGUIV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=W8q+787i;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IaRjEDVR;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7nBHb9e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NY/HbJARxrykCuCB4Tp3Nq5BNppdzWMzzcV4aLoicTI=; b=J6qPGUIVR3LUiXAjI+1o0P7AQQ
	QUBbg4DLcTUPMFkc2FkZwrPCD31UYnRxuf5Tvo1aHN6LgIh5L2FuXtkuhJcrSDMgNDTh6OdHFq3u5
	z0kSrW7IhQRzV190c7iIALalpR84r1Q/JzExIA2VUm0waMiquh3B4zujwkVMqwDzYt4I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTOdE-000000006Bq-3lnF;
	Tue, 17 Nov 2026 19:14:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <jaegeuk@kernel.org>) id 1xTOdD-000000006Bb-2mQD
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 19:14:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MjAfknxVEo6EVhQfKp67NUgJ5pBiDPDSPahd3foUmMY=; b=W8q+787ibXK9Y+qT6jNb1OsA73
 lgsSfKvOCBfyhPoEqSVY5RPbCSvJNqrz3Q+PkEkfuna8e6UnLPjkH02ijTdAZILYXDoCGfwhpe+wl
 YnvvndB7giHYMoNF33TqvQo9LHCTZRxP/yfsjTeOwY1yClQHAcepsoYO8ZHxlUFT6tN0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MjAfknxVEo6EVhQfKp67NUgJ5pBiDPDSPahd3foUmMY=; b=IaRjEDVRwn/NLVPAjsTVT3ZSEE
 x98T9xSfTlvft5qZT0fovNqys4MyWPuCEO5MPEv+t/0cislzmRHu/kQXTwb+Psv07xEBr+ZvHC9cr
 HYp0phGkhnfY1if+ZIEjIu6SYGce2bys6LTYzrCi4BPp7VUFye+6gsVIqII4hAuk/NIA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTOdC-000000002Se-40tl
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 19:14:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 453D16118F;
 Tue, 17 Nov 2026 19:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02E11F000C4;
 Tue, 17 Nov 2026 19:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794942849;
 bh=MjAfknxVEo6EVhQfKp67NUgJ5pBiDPDSPahd3foUmMY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=f7nBHb9ecyZDmSxAb5OTR5BUcHwC6S7V/RWmGcfn/fMRBkvm7y9noE6BnrTIjkrXd
 YKJENXbFFwzSkI5reg4Lsh5TvwNghkgonqk31JFpwA+p60x8YAWHEdINxXmRbRsxNJ
 q+epnd7TISmZGG3RSbcaGsmfB7c8c63IeGaI5QQ2GUnE6UP9JzK7oZ5anYDNBYaQW/
 M/wmTe6RuviCFlKyovpUumNqUnAf+uQ6gueaYORCTPDA3jJkOWawG++1D+/wSjLkJP
 96sjuYvzcozaMSPxvOI3EglSFkVrQXOLrggPL4QEwnYDwaibfdSCYBspHrKymryZzq
 EHgS+maXsL3pg==
Date: Tue, 17 Nov 2026 19:14:07 +0000
To: Daeho Jeong <daeho43@gmail.com>
Message-ID: <avynfxEMXTEmCuP2@google.com>
References: <20261113200904.3010578-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261113200904.3010578-1-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTOdC-000000002Se-40tl
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: set the block size of zoned
 devices to the logical block size
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Could you please fix the build error?

make[2]: Entering directory '/home/runner/work/f2fs-tools/f2fs-tools/lib'
  CC       libf2fs_la-libf2fs.lo
  CC       libf2fs_la-libf2fs_io.lo
  CC       libf2fs_la-libf2fs_zoned.lo
  CC       libf2fs_la-nls_utf8.lo
libf2fs.c: In function 'utf8_to_utf16':
libf2fs.c:127:47: error: 'calloc' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
  127 |         uint16_t *volume_name = calloc(sizeof(uint16_t), MAX_VOLUME_NAME);
      |                                               ^~~~~~~~
libf2fs.c:127:47: note: earlier argument should specify number of elements, later size of each element
libf2fs.c: In function 'utf16_to_utf8':
libf2fs.c:222:47: error: 'calloc' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
  222 |         uint16_t *volume_name = calloc(sizeof(uint16_t), MAX_VOLUME_NAME);
      |                                               ^~~~~~~~
libf2fs.c:222:47: note: earlier argument should specify number of elements, later size of each element
cc1: all warnings being treated as errors
make[2]: *** [Makefile:456: libf2fs_la-libf2fs.lo] Error 1
make[2]: *** Waiting for unfinished jobs....
make[2]: Leaving directory '/home/runner/work/f2fs-tools/f2fs-tools/lib'
make[1]: *** [Makefile:421: all-recursive] Error 1
make[1]: Leaving directory '/home/runner/work/f2fs-tools/f2fs-tools'
make: *** [Makefile:353: all] Error 2

On 11/13, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> The kernel caches a block device in units of its soft block size, which
> is set to the largest power of two that divides the device size, up to
> PAGE_SIZE. On a 16KB page kernel, it is 16KB even for a 4KB logical
> block device, so a buffered 4KB write is written back as a whole 16KB
> unit.
> 
> On a host-managed zoned device, the first write in a unit then moves the
> write pointer of the sequential zone beyond the written data, and the
> next write in the same unit is rejected as an unaligned write, e.g.
> 
>   Buffer I/O error on dev nvme0n1, logical block 24576, lost async page write
>   Error: While writing the quota_blk to disk!!!
> 
> Set the soft block size of zoned devices to their logical block size
> with BLKBSZSET, so that each write covers whole units. If it cannot be
> set and the current one is larger, fail right away instead of failing in
> the middle of the writes. Skip it for dump.f2fs and --dry-run, which do
> not write to the device, and when the page size is not larger than the
> logical block size, as the soft block size is not larger then either.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  lib/libf2fs.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index 93f36ca..b0cdf09 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -922,6 +922,14 @@ void get_kernel_uname_version(__u8 *version)
>  #define BLKSSZGET	_IO(0x12,104)
>  #endif
>  
> +#if defined(__linux__) && defined(_IOR) && !defined(BLKBSZGET)
> +#define BLKBSZGET	_IOR(0x12,112, size_t)
> +#endif
> +
> +#if defined(__linux__) && defined(_IOW) && !defined(BLKBSZSET)
> +#define BLKBSZSET	_IOW(0x12,113, size_t)
> +#endif
> +
>  #if defined(__APPLE__)
>  #include <sys/disk.h>
>  #define BLKGETSIZE	DKIOCGETBLOCKCOUNT
> @@ -1047,6 +1055,34 @@ int get_device_info(int i)
>  		else if (dev->sector_size < sector_size)
>  			dev->sector_size = sector_size;
>  #endif
> +#if defined(BLKBSZGET) && defined(BLKBSZSET)
> +		/*
> +		 * The page cache of a block device is managed in units of its
> +		 * soft block size, which can be as large as PAGE_SIZE. A
> +		 * smaller write is then written back as a whole unit, which
> +		 * moves the write pointer of a sequential zone beyond the
> +		 * written data, and makes the next write in the same unit
> +		 * fail. Use the logical block size for zoned devices, and do
> +		 * not go on to write to the device if it cannot be set. The
> +		 * soft block size is larger than the logical block size only
> +		 * when PAGE_SIZE is, so leave it alone otherwise.
> +		 */
> +		if (dev->zoned_model == F2FS_ZONED_HM &&
> +				c.func != DUMP && !c.dry_run &&
> +				sysconf(_SC_PAGESIZE) > (long)dev->sector_size) {
> +			int bsz = dev->sector_size;
> +			int cur_bsz = 0;
> +
> +			if (ioctl(fd, BLKBSZSET, &bsz) < 0 &&
> +			    (ioctl(fd, BLKBSZGET, &cur_bsz) < 0 ||
> +			     cur_bsz > bsz)) {
> +				MSG(0, "\tError: Cannot set the block size "
> +					"of %s to %d\n", dev->path, bsz);
> +				free(stat_buf);
> +				return -1;
> +			}
> +		}
> +#endif
>  #ifdef BLKGETSIZE64
>  		if (ioctl(fd, BLKGETSIZE64, &dev->total_sectors) < 0) {
>  			MSG(0, "\tError: Cannot get the device size\n");
> -- 
> 2.56.0.611.g1030f0b940-goog
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
