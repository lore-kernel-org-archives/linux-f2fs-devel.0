Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D4BC5DF9C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 05:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CVak7MU0iLL8xIM/4EHE3brNxMa2PYyR3Nmg6x/aOzA=; b=JDYgrXWD0Enr5k8otnv3V63ti6
	dJZxnMP4Zql4yhK9l5myggKzYH/PeNa15TEAVCGxLrgJaQqFclCzvF8jud14UmIxuP4HZamwf19r3
	ygk7T2gXlqDzO5rogjSLSGsXItr7zrsaLD4eIYO0Njg2MAp7cr+X4H4Sglh9b7uTKmPk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyk1g-00023y-Ew;
	Tue, 25 Aug 2026 05:48:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+b87911c0b4807dbed12c+8402+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wyk1e-00023k-Mz for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 05:48:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HFDnRsAw55zolKK+KEfWLFf2Cew1IzCwKp3SV1h9ny0=; b=MDDZlyyQgc1rTpWLWHkmxf+tEn
 gUmZXEM5pcpeq+QiSgKak7S8M98ZXi+F3KLNEKaTgY+1t/knCU8jeC2UN6g1MZ3C+50WYXvMi2JkZ
 9u0XuBJKnext2FQE8MNSYop/v46TQ5l8HWfoewTSK0KL/9tC1WAIXeldDt8/FXujoCKI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HFDnRsAw55zolKK+KEfWLFf2Cew1IzCwKp3SV1h9ny0=; b=Tj/9nHaRU7XKGHPM716Nn1ik8k
 FrgFutHoUcWC4amRaI2FfA4Lv++SOqlEWdF06/6uAyUgtsJlySNXqcoeJJSJajx9x25fHPF7ishvO
 GyOTe9jI2LE2YXQbpZw4aFJSwVSUXjP01BgIAiClGM3+jiX9Ds+ZXl+BMWtpkjttbN5Q=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyk1e-0003Ke-BY for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 05:48:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=HFDnRsAw55zolKK+KEfWLFf2Cew1IzCwKp3SV1h9ny0=; b=S2rGP7x2afrlPeM7TeFX/GgDAb
 J/pPXDGI4vv42X7cRxn9b9UqXR+bf/fFu4/5++cnanKpailmvj5ESbtZA1tP2zEJGE/mTMQDo4Xim
 EyFsIZ1wbBmDEliMGytpCYBqsHfH8KnqbbuyAr19ILsL+Uy9capB9//lHN36nD3sQ7Zp9zu//EuP+
 Q/MFnC0zZ9ahzeM0HvFvNUYnt0fhEPKdoL0JQmMnjZkYCAa84HAU91hh1IWSTa07+H3riOgio5ULW
 ssGReOnlnyEypSMOEBn8GkDtukvmKss6QrAc9vgC+uosveJaDhkMyWFQFJ3K27qa4yjs5f5Z+H7Qz
 z2c+nhXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wyk1W-00000000CeW-0gyC;
 Tue, 25 Aug 2026 05:48:38 +0000
Date: Mon, 24 Aug 2026 22:48:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Wenjie Qi <qwjhust@gmail.com>
Message-ID: <ao0stlR57iUgrY2Y@infradead.org>
References: <20260820071438.695893-1-qiwenjie@xiaomi.com>
 <cover.1787564706.git.qiwenjie@xiaomi.com>
 <ef06bf67db77a009d5fc2932069c2b3366d972c4.1787564706.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ef06bf67db77a009d5fc2932069c2b3366d972c4.1787564706.git.qiwenjie@xiaomi.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wyk1e-0003Ke-BY
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: complete dropbehind write bios
 in safe task context
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 Tal Zussman <tz2294@columbia.edu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 24, 2026 at 06:33:46PM +0800, Wenjie Qi wrote:
> Buffered RWF_DONTCACHE writes invalidate dropbehind folios from writeback
> completion. Keep normal and dropbehind folios in separate write bios, and
> defer dropbehind bios to sbi->wq unless completion runs in preemptible task
> context.
> 
> Use an F2FS-local context check for this decision. Task context alone is
> not sufficient: preemption may still be disabled, or completion may run in
> a preemptible RCU read-side critical section.
> 
> Keep the existing large-ATC deferral unchanged.

Please reuse all the helpers added in common code in 7.3 for deferring
bios and tsting if that that is neeeded instead of badly reinventing
the logic.  It also is really helpful to Cc people involved with the
code and the relevant mailing lists.

> 
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>  fs/f2fs/data.c | 50 ++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 6ae0eb37d20..774a3e2d8e3 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -21,6 +21,7 @@
>  #include <linux/fiemap.h>
>  #include <linux/iomap.h>
>  #include <linux/fserror.h>
> +#include <linux/rcupdate.h>
>  
>  #include "f2fs.h"
>  #include "node.h"
> @@ -43,9 +44,29 @@ struct f2fs_folio_state {
>  
>  struct f2fs_bio {
>  	struct work_struct work;
> +	bool dropbehind;
>  	struct bio bio;
>  };
>  
> +static struct f2fs_bio *to_f2fs_bio(struct bio *bio)
> +{
> +	return container_of(bio, struct f2fs_bio, bio);
> +}
> +
> +/* Keep in sync with the proposed block-layer bio_in_atomic(). */
> +static bool f2fs_bio_in_atomic(void)
> +{
> +#ifdef CONFIG_PREEMPTION
> +	if (rcu_preempt_depth())
> +		return true;
> +#endif
> +#ifndef CONFIG_PREEMPT_COUNT
> +	return true;
> +#else
> +	return !preemptible();
> +#endif
> +}
> +
>  #define	F2FS_BIO_POOL_SIZE	NR_CURSEG_TYPE
>  
>  int __init f2fs_init_bioset(void)
> @@ -426,12 +447,13 @@ static void f2fs_write_end_io(struct bio *bio)
>  
>  	sbi = bio->bi_private;
>  
> -	if (in_atomic() && bio->bi_iter.bi_size > sbi->max_atc_write_bio_size) {
> -		struct work_struct *w;
> +	if ((to_f2fs_bio(bio)->dropbehind && f2fs_bio_in_atomic()) ||
> +	    (in_atomic() &&
> +	     bio->bi_iter.bi_size > sbi->max_atc_write_bio_size)) {
> +		struct work_struct *work = &to_f2fs_bio(bio)->work;
>  
> -		w = &container_of(bio, struct f2fs_bio, bio)->work;
> -		INIT_WORK(w, f2fs_write_end_io_work);
> -		queue_work(sbi->wq, w);
> +		INIT_WORK(work, f2fs_write_end_io_work);
> +		queue_work(sbi->wq, work);
>  	} else {
>  		f2fs_write_end_bio(bio);
>  	}
> @@ -530,6 +552,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
>  	bio = bio_alloc_bioset(bdev, npages,
>  				fio->op | fio->op_flags | f2fs_io_flags(fio),
>  				GFP_NOIO, &f2fs_bioset);
> +	to_f2fs_bio(bio)->dropbehind =
> +			!is_read_io(fio->op) && folio_test_dropbehind(fio->folio);
>  	bio->bi_iter.bi_sector = sector;
>  	if (is_read_io(fio->op)) {
>  		bio->bi_end_io = f2fs_read_end_io;
> @@ -825,6 +849,13 @@ static bool page_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
>  	return bio->bi_bdev == f2fs_target_device(sbi, cur_blkaddr, NULL);
>  }
>  
> +static bool f2fs_bio_dropbehind_mergeable(struct bio *bio,
> +					  struct f2fs_io_info *fio)
> +{
> +	return to_f2fs_bio(bio)->dropbehind ==
> +		folio_test_dropbehind(fio->folio);
> +}
> +
>  static bool io_type_is_mergeable(struct f2fs_bio_info *io,
>  						struct f2fs_io_info *fio)
>  {
> @@ -1017,8 +1048,10 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>  
>  	trace_f2fs_submit_folio_bio(data_folio, fio);
>  
> -	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
> -						fio->new_blkaddr))
> +	if (bio &&
> +	    (!page_is_mergeable(fio->sbi, bio, *fio->last_block,
> +				fio->new_blkaddr) ||
> +	     !f2fs_bio_dropbehind_mergeable(bio, fio)))
>  		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
>  alloc_new:
>  	if (!bio) {
> @@ -1118,7 +1151,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
>  			      fio->new_blkaddr) ||
>  	     !f2fs_crypt_mergeable_bio(io->bio, fio_inode(fio),
> -				bio_folio->index, fio)))
> +				bio_folio->index, fio) ||
> +	     !f2fs_bio_dropbehind_mergeable(io->bio, fio)))
>  		__submit_merged_bio(io);
>  alloc_new:
>  	if (io->bio == NULL) {
> -- 
> 2.43.0
> 
---end quoted text---


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
