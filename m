Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41CCC61DB4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vh71sYaP9OTyzlDIausC5ljG8M+JvJT5dp0beFnVsTw=; b=IHKbm6EULytmyuijHCe4Q6RqR8
	XMV1WYdmEVBr6TaWIkHXfCbSXU9/RGfPqHVpVmL2kgxg0lOwEI55C+yjlpdsqKK6z6VDWzXGqGgnn
	pBkhieK3PZoNsFiTd6bnk0j9mmoWGTDhZi33rrg5ck6Sdx5leUndPHNKeqZHK//CI7Bs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wykld-0006Jv-RH;
	Tue, 25 Aug 2026 06:36:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyklc-0006Jh-Da
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 06:36:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h6uheborK9kDsnT166ceQL15+6H7t38OLGChs04wgko=; b=KTbrVDuVRQ5BthLvQuwdSMKcG9
 l3JPZWAcNmKx+SawaXBTUzauU3Y2X7pu+5EhcsmCB8kOgvKX/ythRIz4Vk/9oa6psKP4Wh33lsiaG
 BkcpLPB0F+xvloCd2J6v7/YHmvChgfNJDzWJMLiNHWcGNeP8OlYCfnKH5HFMS1EI/alA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=h6uheborK9kDsnT166ceQL15+6H7t38OLGChs04wgko=; b=c4RWM3khIZ/PsXK97QRnPdacG1
 Q7ee7j/i1nYgewDqDd4bvTbFtLSP92b8U8qv++qhJeU4giuLy/uvbLk8epjS0c6w9ayx+5PbrE7fo
 byDZ4QGqY14SMMEj/oRtWI0NayNE5PUwk51QHLsvfVLJhxMnN3XLpyFgFfsYpGNw5esQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wykla-0006ff-JR for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 06:36:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F05AD6011F;
 Tue, 25 Aug 2026 06:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5361F000E9;
 Tue, 25 Aug 2026 06:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787639768;
 bh=h6uheborK9kDsnT166ceQL15+6H7t38OLGChs04wgko=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=jpPphzTLzA5lfTsvuSCJU7WZyCU/MlYpMbphSlCpf8n2iWkvZkSJyG30AFzLW8PKL
 RARaq/a+PH+YokM9eeYEL5Nkq4wlYjLsOYDf4+vEDKGOHMupCCEmLbOdSi8n0lXXmu
 tUn38wugnFDIUf7uqGjSSnIq7OWFTvEN7KJp7z1ffBh3diQWB0q+O2U+dKNsIexhR+
 4ejcnU+QM3B0e+fnHMQUIqK0ntXlS2RXDMA1SpDWkhKutel4N/5Qf5dyopLmpio1af
 N6xyqi8xBpJ6/aJHvNjuTIcuvTaFpqX6a37LgYCtMfIAUwnjnsL1kGUHaqPPEy7VJy
 oeJ6oEbBNj66w==
Message-ID: <80da6dab-220e-42a3-bbad-a793d653ee37@kernel.org>
Date: Tue, 25 Aug 2026 14:36:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>
References: <20260824134731.3704352-1-chao@kernel.org>
 <20260824134731.3704352-4-chao@kernel.org>
 <20260825054205.397297-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260825054205.397297-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wykla-0006ff-JR
Subject: Re: [f2fs-dev] [PATCH v2 03/12] f2fs: cache: introduce shrinker
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/25/26 13:42, Wenjie Qi wrote:
> Hi Chao,
> 
>> static unsigned long __count_cache(struct f2fs_sb_info *sbi)
>> {
>> 	return sbi->meta_blocks.num_entries +
>> 		sbi->node_blocks.num_entries;
>> }
> 
> and the scan path includes:
> 
>> freed += f2fs_do_shrink_cache(COMPRESS_CACHE(sbi),
>> 					nr_to_scan - freed);
> 
> The count path includes the meta and node caches, while the scan path also
> includes `COMPRESS_CACHE`.
> 
> Is `COMPRESS_CACHE` intentionally excluded from `__count_cache()` even though
> `f2fs_shrink_cache()` scans it?

Oh, I missed to add it, will fix.

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
