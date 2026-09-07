Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D54C79F9E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eR2FwXC/3eLaob+6LMNhsTln/LW6f5UD8xHKTzyvdXk=; b=FSAhO/PIIUw8zgYJ4y/PA3gjOH
	L1frJUF0cK5u7F2LeS8uJUT3NNSuZddKsRwWz/6xl/2binWLVwjwyZyXOyrur6dAO0fh+KM14kUh6
	42iUdOeqSswyeUSeBwz7rI2CdoXXpkeNf+oT6lE/foiEGNXDhvUmN/Kiig4s7Z+igU3A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3WWr-0001TE-4j;
	Mon, 07 Sep 2026 10:24:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x3WWq-0001T8-5g
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 10:24:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9BqDLmGnAkMHp9vwRniiZuI/ddgBPW2A/NeBEBZzQS8=; b=VwBp0/7uBx+ywYxL5VrU6LlOG6
 uO4nWGkJMe9ypjFlUXpyMZ6SS2xSKmAUEQOrr8huulUVLCrTeOBZdbUHUN9evDJ9Dcbvfbhc2InjY
 yacD9z2ToVOAXlKB9Hd5Bvho7wZBtlIi6JYBzCDqPcvjxbJpaji49Ku2r596bi5m2GWU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9BqDLmGnAkMHp9vwRniiZuI/ddgBPW2A/NeBEBZzQS8=; b=iUSkQ6MdbDpF2+Unp/RoYUlkQ2
 6bxwDhuRcei0i46LIPo/g6uUHjSm2SUxCa6Sh/fzRCDDJF3FQusOVD1p2iUHHVRV7bXvOwp8Fg/+Y
 cul2MZyttaUUhTJskjf1seSKFIJER/F+qtsBrW2BYcSczhpimRrY5pV0hgqeLR2p8iQo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3WWo-0005QS-72 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 10:24:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 58BCF60D8D;
 Mon,  7 Sep 2026 10:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EF11F00A3F;
 Mon,  7 Sep 2026 10:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788776676;
 bh=9BqDLmGnAkMHp9vwRniiZuI/ddgBPW2A/NeBEBZzQS8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=FtXN28sxVnTxLlot/tbGgKn54hYdfQDVpBNPETtLXAunDWU81VOHQTOLlu26rJ8WQ
 aBy1Zh9dPjbQ2OgxR53PQGQnJIoVSfKdt727BvlCEnKArD8P8/Yo+RQ68sqkxGMa28
 lgGBGLU+yHp3Tu5zZru6roNOjkq2b94KRXI0D0HW+Su4rY+xjIz0lzaziOZXZ4NY/f
 K/BkA98SIlMqgtlofTMtwLDBbYwiVgufOcnhPYcXpZqy5H3CJ5ytWYOxumDkkwRFPH
 QS1OCHzkLfTNoWT6s+6lUxGwFwgAjdYSA0JOKmV0SGHpdV5izJ/V1VSuV1FfYN8fPn
 FiyIrl8nP5cOA==
Message-ID: <f9839ca2-1554-450d-9e98-72d686a8402d@kernel.org>
Date: Mon, 7 Sep 2026 18:24:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
References: <f1ffd3a5-9fdc-4f26-bd9d-5f55e563f800@kernel.org>
 <20260907095759.2461366-1-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260907095759.2461366-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x3WWo-0005QS-72
Subject: Re: [f2fs-dev] [PATCH 12/14] f2fs: handle block cloning within the
 same large folio
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Thanks, better.

On 9/7/26 17:57, Nanzhe Zhao wrote:
> On Mon, 31 Aug 2026 16:19:05 +0800, Chao Yu wrote:
>> A lot of codes are redundant, can we add fdst = fsrc;
>> So that we can replace fsrc w/ fdst, and clean up the redundant codes
>> below:
>> Thanks,
> 
> Thanks for the review. I'll restructure the else branch as suggested:
> 
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -56,25 +56,66 @@
>   			f2fs_put_dnode(&dn);
>   		} else {
>   			struct folio *fsrc, *fdst;
> +			size_t src_off, dst_off;
> +			bool same_folio;
>   
>   			fsrc = f2fs_get_lock_data_folio(src_inode,
>   							src + i, true);
>   			if (IS_ERR(fsrc))
>   				return PTR_ERR(fsrc);
> -			fdst = f2fs_get_new_data_folio(dst_inode, NULL, dst + i,
> -								true);
> -			if (IS_ERR(fdst)) {
> -				f2fs_folio_put(fsrc, true);
> -				return PTR_ERR(fdst);
> +
> +			src_off = offset_in_folio(fsrc,
> +						(loff_t)(src + i) << PAGE_SHIFT);
> +
> +			/*
> +			 * For same-inode operations (collapse/insert), src and
> +			 * dst may fall within the same large folio.  Detect this
> +			 * to avoid self-deadlock on folio lock: in that case the
> +			 * destination folio is fsrc itself and only its block
> +			 * needs reservation.
> +			 */
> +			same_folio = src_inode == dst_inode &&
> +					folio_contains(fsrc, dst + i);
> +			if (same_folio) {
> +				struct dnode_of_data dn;
> +
> +				/* Reserve block for dst before copying */
> +				set_new_dnode(&dn, dst_inode, NULL, NULL, 0);
> +				ret = f2fs_reserve_block(&dn, dst + i);
> +				if (ret) {
> +					f2fs_folio_put(fsrc, true);
> +					return ret;
> +				}
> +				fdst = fsrc;
> +			} else {
> +				fdst = f2fs_get_new_data_folio(dst_inode, NULL,
> +							      dst + i, true);
> +				if (IS_ERR(fdst)) {
> +					f2fs_folio_put(fsrc, true);
> +					return PTR_ERR(fdst);
> +				}
>   			}
>   
> +			dst_off = offset_in_folio(fdst,
> +					(loff_t)(dst + i) << PAGE_SHIFT);
>   			f2fs_folio_wait_writeback(fdst, DATA, true, true);
> -
> -			memcpy_folio(fdst, 0, fsrc, 0, PAGE_SIZE);
> +			memcpy_folio(fdst, dst_off, fsrc, src_off, PAGE_SIZE);
> +			if (folio_test_large(fdst)) {
> +				f2fs_ffs_find_or_alloc(fdst);
> +				f2fs_ffs_mark_subrange_uptodate(fdst,
> +							dst_off, PAGE_SIZE);
> +				f2fs_ffs_mark_subrange_dirty(fdst, dst_off,
> +							    PAGE_SIZE);
> +			}
>   			folio_mark_dirty(fdst);
> +			if (same_folio && i_size_read(dst_inode) <
> +			    ((loff_t)(dst + i + 1) << PAGE_SHIFT))
> +				f2fs_i_size_write(dst_inode,
> +					((loff_t)(dst + i + 1) << PAGE_SHIFT));
>   			folio_set_f2fs_gcing(fdst);
>   			f2fs_folio_put(fdst, true);
> -			f2fs_folio_put(fsrc, true);
> +			if (!same_folio)
> +				f2fs_folio_put(fsrc, true);
>   
>   			ret = f2fs_truncate_hole(src_inode,
>   						src + i, src + i + 1);
> 
> Thanks,
> Nanzhe



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
