Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5EAC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zjb1Gu2VJVqglrGZJRvXGaaPgWKDvoUsh8Pjbmx9J8A=; b=Kkoxobbm8kQ5Z3A721mEw5Hnrh
	ZDQK9jjiYsBvrXFnpI0qPFiwxsyBPU+QOvnO+nAULKg1kbvu+jMx5i7mp7qEWdooMz0NpKeaVTTZg
	/+73hWTMRe/J2lSN2ox8knki/NsDvzYg3oauq4uxtOSU66UMN5RG+9/DpJBOkVwhaK3g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0xEh-0005Rh-CA;
	Mon, 31 Aug 2026 08:19:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x0xEe-0005QH-Jo
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 08:19:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EB7RUR5W520SXZF149cnRfIVevdYFi24n9QrujO/5fI=; b=XOa+IIsHBPWLs2XWVVLwGqykje
 WFCs4t6s0Ei2nvPnE1cPk2CA2nekmCtLj4H3/NPcbAulryBXEDpVzDn33wb3F5pQbn5NwIEnDnp5a
 +eKE3il/3qIdkTN+M4Jamu40qJ7LAhRob4Z/wY796FMGfIBBhJ7yVHdvn6JblnuHCO+o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EB7RUR5W520SXZF149cnRfIVevdYFi24n9QrujO/5fI=; b=O4+/cA6vMSstoZ7fEJuLk1BFix
 fAiHY/eTudmH77Mm8yisshhwCWspu0H+ttzyxWQXAoMKT3g31ktVuQoxDlFV6Yz6CVk4sj95NgJrh
 PSXrSWVwXt93zG8ejKHilIAbK2XZg+Qe/derNnoqTy7x+2WX0zZ6fHPohlYO5cynyBS8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0xEZ-0003yu-Mf for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 08:19:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 552484184F;
 Mon, 31 Aug 2026 08:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0FB1F000E9;
 Mon, 31 Aug 2026 08:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788164350;
 bh=EB7RUR5W520SXZF149cnRfIVevdYFi24n9QrujO/5fI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=EfPCLmQ+GxQUktyh3EMn5OCXN4lFZSBvVLK17bcEgVDbTD9uR51LJ6Em5q1btwLbD
 ejyo7p8QFxJVipPGHdGTZU9SI9PGaVZO7sOibYD90R1XgKe0nNIxT84+REr90FBEl/
 xlMjk0lygRepAdmrlqQovrJh/MVFA6fkJtyEEPR6mgXjUiQhOcs2rsnuF+zwEHbovZ
 0VM4ee/VzF737rk2j/WlsAGpsJOwVIpf2Y19mylFxLI0Df8f0ocu12kMatbOdZaH+2
 QAW3hh1kIeAA/D7evSUN74PHXIlt+6DKYC46EaWw3y3Y4qpLf6CRfaBIcZA80ticIc
 nw4bE72+yWINA==
Message-ID: <f1ffd3a5-9fdc-4f26-bd9d-5f55e563f800@kernel.org>
Date: Mon, 31 Aug 2026 16:19:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
 <20260826130916.2231342-2-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260826130916.2231342-2-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x0xEZ-0003yu-Mf
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
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/26/26 21:09, Nanzhe Zhao wrote:
> With large folios, the source and destination block in __clone_blkaddrs()
> can belong to the same folio during same-inode operations such as
> collapse range and insert range.
> 
> In that case, locking the source folio and then looking up the
> destination folio can try to lock the same folio again.  It also copies
> from and to offset 0, which is only correct for order-0 folios.
> 
> Detect the same-inode, same-folio case before looking up the destination
> folio.  Then in this case,we reserve the destination block explicitly.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>   fs/f2fs/file.c | 76 ++++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 64 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4272013dbe38..b82acbc3240f 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1581,25 +1581,77 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
>   			f2fs_put_dnode(&dn);
>   		} else {
>   			struct folio *fsrc, *fdst;
> +			size_t src_off, dst_off;
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
> -			}
>   
> -			f2fs_folio_wait_writeback(fdst, DATA, true, true);
> +			src_off = offset_in_folio(fsrc,
> +						(loff_t)(src + i) << PAGE_SHIFT);
> +
> +			/*
> +			 * For same-inode operations (collapse/insert), src and
> +			 * dst may fall within the same large folio. Detect this
> +			 * to avoid self-deadlock on folio lock.
> +			 */
> +			if (src_inode == dst_inode &&
> +			    folio_contains(fsrc, dst + i)) {
> +				struct dnode_of_data dn;

A lot of codes are redundant, can we add fdst = fsrc;

So that we can replace fsrc w/ fdst, and clean up the redundant codes blow:

Thanks,

> +
> +				/* Reserve block for dst before copying */
> +				set_new_dnode(&dn, dst_inode, NULL, NULL, 0);
> +				ret = f2fs_reserve_block(&dn, dst + i);
> +				if (ret) {
> +					f2fs_folio_put(fsrc, true);
> +					return ret;
> +				}
> +
> +				dst_off = offset_in_folio(fsrc,
> +						(loff_t)(dst + i) << PAGE_SHIFT);
> +				f2fs_folio_wait_writeback(fsrc, DATA, true, true);
> +				memcpy_folio(fsrc, dst_off, fsrc, src_off,
> +					    PAGE_SIZE);
> +				if (folio_test_large(fsrc)) {
> +					f2fs_ffs_find_or_alloc(fsrc);
> +					f2fs_ffs_mark_subrange_uptodate(fsrc,
> +								dst_off, PAGE_SIZE);
> +					f2fs_ffs_mark_subrange_dirty(fsrc, dst_off,
> +								    PAGE_SIZE);
> +				}
> +				folio_mark_dirty(fsrc);
> +				if (i_size_read(dst_inode) <
> +				    ((loff_t)(dst + i + 1) << PAGE_SHIFT))
> +					f2fs_i_size_write(dst_inode,
> +						((loff_t)(dst + i + 1) << PAGE_SHIFT));
> +				folio_set_f2fs_gcing(fsrc);
> +				f2fs_folio_put(fsrc, true);
> +			} else {
> +				fdst = f2fs_get_new_data_folio(dst_inode, NULL,
> +							      dst + i, true);
> +				if (IS_ERR(fdst)) {
> +					f2fs_folio_put(fsrc, true);
> +					return PTR_ERR(fdst);
> +				}
>   
> -			memcpy_folio(fdst, 0, fsrc, 0, PAGE_SIZE);
> -			folio_mark_dirty(fdst);
> -			folio_set_f2fs_gcing(fdst);
> -			f2fs_folio_put(fdst, true);
> -			f2fs_folio_put(fsrc, true);
> +				dst_off = offset_in_folio(fdst,
> +						(loff_t)(dst + i) << PAGE_SHIFT);
> +				f2fs_folio_wait_writeback(fdst, DATA, true, true);
> +				memcpy_folio(fdst, dst_off, fsrc, src_off,
> +					    PAGE_SIZE);
> +				if (folio_test_large(fdst)) {
> +					f2fs_ffs_find_or_alloc(fdst);
> +					f2fs_ffs_mark_subrange_uptodate(fdst,
> +								dst_off, PAGE_SIZE);
> +					f2fs_ffs_mark_subrange_dirty(fdst, dst_off,
> +								    PAGE_SIZE);
> +				}
> +				folio_mark_dirty(fdst);
> +				folio_set_f2fs_gcing(fdst);
> +				f2fs_folio_put(fdst, true);
> +				f2fs_folio_put(fsrc, true);
> +			}
>   
>   			ret = f2fs_truncate_hole(src_inode,
>   						src + i, src + i + 1);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
