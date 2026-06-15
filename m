Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D613CD98C5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 03:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MJhSO6u1DUGJtuwbQl2AMKNYECEff6ftiiUjFWUNrt4=; b=RgNk6CTDkp4pJ6U+AGr5ddoOPk
	xVxP7yL0EsnaHDVWfS2qYoxse4cSwMG+/SdodxUCqw4lbHHAdh/6xsUfLE4PkgqQEakrA7b5mgClv
	ptgja4QOzlK0JgXAFG5mgg8GMrZcqVCIlmQGTnbk52JqnnbwgJf7w+bqZ6pTxzNjv5ig=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wYxzc-0002G6-SS;
	Mon, 15 Jun 2026 03:28:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wYxzb-0002Fz-Qd
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 03:28:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CYpMGm4KPltzF02KV9EHN/2ezBlSWZ5vgvsKiinpFak=; b=aRkAdtuKzLGTfVzL3NadnE87Ds
 LqYArM5LmBBnLQbeyZD6Fm2+VEgbHqtaGEHi0a7N4Z6FJELVQSyU980nHwv7sqHDiDPXRTFY69sM2
 RGCJZdfoLYhOGw9+yKhVuZtRN3nmQnUF1ALTFTzkhCcsh3S+DSxrcD2CUPNcgZ45yokA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CYpMGm4KPltzF02KV9EHN/2ezBlSWZ5vgvsKiinpFak=; b=nGZAGEG655xQ9s/dJsBT73u7sf
 5qXPN9JRs984TPtowzY4/m/7eXesVUmgNSwZ9aT3uMqofuuEV/k5Ka0l+aOrQTudTUbfCU+pLWSjl
 U7+OrVM4TKxIli/QQDRCH1lsMl+HaJWrpCMSUc3aTyg5+ePsk6J7/OcGB6vncksLwnsw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wYxzb-0000JW-E0 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 03:28:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 73B29438AA;
 Mon, 15 Jun 2026 03:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102101F000E9;
 Mon, 15 Jun 2026 03:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781494077;
 bh=CYpMGm4KPltzF02KV9EHN/2ezBlSWZ5vgvsKiinpFak=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=iCJdd1BBOYEfa9/OvEQizXQr5Q9FpcuARTxgitI29CRNXZHBDcZTBbieHbEex0zwT
 92flQo34nWxi7nsEtJL6P6LBgOoPdCf5jOs2D9P+MrX+/Rqee8VLetBJez6R1opfsN
 CQE97UaKKti5vLd64m4PJv8l24Ahv8VZsSIDVpXvzSmiNyx4mAcP3kwN9mfaqSc101
 2HKlXjZwIQb2UqHqJPfRi2gWSlSSG4O5daYnlWMQIAmdsYAUtQyoLAVNnJNUemKAZW
 JfzC+X4LLdIsTw8houA7vEWGQeXH0Bnq38h/dOly3jE4JRvYjMlT/GyIdHZ5qMzYja
 x6mU8Yp9sINtg==
Message-ID: <fd4d8227-6de7-4625-83ac-c2253b0fbe26@kernel.org>
Date: Mon, 15 Jun 2026 11:27:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260610143735.3169935-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260610143735.3169935-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wYxzb-0000JW-E0
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: reject setattr size changes on
 large folio files
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
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/10/26 22:37, Wenjie Qi wrote:
> F2FS large folios are only enabled for immutable non-compressed files.
> Writable open and writable mmap reject such mappings, but truncate(2)
> through f2fs_setattr() misses the same guard.
> 
> If FS_IMMUTABLE_FL is cleared while the inode is still cached, the mapping
> can keep large-folio support and ATTR_SIZE can change i_size. Reject size
> changes in that state.
> 

Cc: stable@kernel.org

> Fixes: 05e65c14ea59 ("f2fs: support large folio for immutable non-compressed case")
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
