Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F20ECA9EC7
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Oct 2026 01:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8MV9XtRVaDF2ZH3tuEQ3SEwdHJlp7hWLKf1At4P4Kzw=; b=MuzJpmTl6QRI9K3D4tDKQ3ImcQ
	O5bN8+xUcmV6GntEEybpv7A9p6Gr1TCS8bqvXw/OgPjIcplNjaIdyXZ4sTE5Ohlv/fhtAiIcSfYVt
	eGzqORFRRq1v7ca70KM6cD+Wz6BaQPvVqAd+16mayiwfMrx8s7nH0guFdzh7HCV+aoV8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFi7z-0002nQ-FQ;
	Sun, 11 Oct 2026 01:13:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xFi7y-0002nK-SQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 01:13:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9K67bx81U10M4Fu5DLdzbkZG3i6qlYP0NLfLYSExQNA=; b=NiwrjoCoeLJOFsLtuOayh/Uk55
 atkY3sGD1Pv4ZkjWMZJZQoLyt8avM1vXd8gkPIQEeCRO+n8oCcEAdbRLQUuQFikregSXdjcqzqWLD
 cZcc668DWJb3yzCW80838VS+jJ5qhZh9ubReKJacuFyG8s8B0v2iMrmAKiMwYATNQ92c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9K67bx81U10M4Fu5DLdzbkZG3i6qlYP0NLfLYSExQNA=; b=h0XkySauVOTb0VOOQFoj71uDHs
 Sjxa5TT8Q2OteyEDD2XAEsnbVE9inuqp8LZ6EQ7Tyxr47lW36s5/QpcgT9qvGogjw0r6c4y4V+aEw
 jXxCRFh9C7KaFMT1iItlHzMeEd9mEPumOdpT7BSgncCnz/Y8OXm0/djZdRpiTNaMTz+o=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFi7v-0005qo-Ts for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 01:13:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4391343662;
 Sun, 11 Oct 2026 01:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814BF1F000FF;
 Sun, 11 Oct 2026 01:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791681198;
 bh=9K67bx81U10M4Fu5DLdzbkZG3i6qlYP0NLfLYSExQNA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=NisgHLVkzJwt/Jgyl33gc2ENC+kqGxT/1LKPp0yN0dzgoPf/zr8rmW3NxPI9c0SBb
 /UxF9cip1vPjvNMMOVGABGKuVG8R9pcqXm1z+88KyTxordCe5jfeimllqB9XNaH7EA
 kTiL4KMmEpQ16TCG+T1AlTC2rBfF5A2y/WkoX+uhyoVjoBWjYdMb8GJJsUuzkQKZrk
 uOHanqYddzz3EB4amMNGEu3K0P3K5SUL3kxGqjkbjYxDBtkyulFUDz44kA0fORm2h5
 47kkh3L4QSTGBgMwaTtl1N/AcdjJ/kFzRIkoUUOUmPB3iGnPC6akVXpBNVwBNAOen2
 9FeS7kgPuDXJA==
Message-ID: <2a9c45d2-bf54-4cf8-8747-5312b03ac206@kernel.org>
Date: Sun, 11 Oct 2026 09:13:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Juhyung Park <qkrwngud825@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20261005201605.693574-1-qkrwngud825@gmail.com>
 <20261005201605.693574-2-qkrwngud825@gmail.com>
Content-Language: en-US
In-Reply-To: <20261005201605.693574-2-qkrwngud825@gmail.com>
X-Headers-End: 1xFi7v-0005qo-Ts
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs-tools: remove LZ4_MEMORY_USAGE
 definition
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/6/26 04:16, Juhyung Park wrote:
> liblz4 defines this from r118's commit back in 2014.
> 
> Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
