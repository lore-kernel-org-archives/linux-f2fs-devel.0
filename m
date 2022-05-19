Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0ABC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 May 2022 11:32:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nreOh-00042W-Si; Thu, 19 May 2022 11:32:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nreOg-00042N-JZ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 11:32:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6ZYHmKTx9sXA3So9TM/1Hch0rPu/ObUVIinB6djeFbk=; b=P3bqa+txmkGanw5EOhwyMqZAoO
 OcV11fBOa/Avxz302OZNAl/Ckn91/3QsaXLqMPhiA0zr4wKzt/9XH/RLHCymfykw5V1jOHHTYSxaB
 c1i3E8TOAVkvbjrH7lD95eMGrF2pmElSBC6ANM8FjCSsY99ltehNxoEW4K4TBvUsianM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6ZYHmKTx9sXA3So9TM/1Hch0rPu/ObUVIinB6djeFbk=; b=bDl2GNm40ZUnld0rpPdsu9jJuC
 XHILmvOaUu0rHlvh/URc9pWavYV+H8GtHGt8wsIw1WZSXGa2S+/31tVCw6ydu7aWYb+fW+0lEUj73
 FzERYVZcQVJTxJtqZw7l3uuyAidrhaCaETPOTr52Rnm3AwyzA8dRApwVesTChIrpQ1Js=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nreOg-0093fd-B5
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 11:32:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F27B761B16;
 Thu, 19 May 2022 11:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA442C385AA;
 Thu, 19 May 2022 11:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652959964;
 bh=1n+/a9vU24s3NevaoyfnBZGBKnGFH0VWAkQ5iWSSV00=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PfC+jIYoVcvbOzUv/x+k5HwhStSv2URYAiPX8UZjabwkzrl4Vxc13s2S2Pmg5YKiK
 5hBDuklY1QGOnS3fxLitjCQdUVQQl1uzN8htchnoCMF1o0xwi0XYCqTc1ecTVA5UMR
 wQ69du0f2XNME1fUhOYptYLZPwVd4xHYwHDU+fTv0n6AHuOYOpAfGFS0cRcXpvCVk7
 AFRg5geNcGkimCGvYqm/X0aR/nA6CYzO0rXsswZDoetg+AWM2FdbVihDPq1Y0HhX84
 PsrmCY13MTiuUR8sAYTzQR7TtVSX5X2s1a27I5UR0cAuMKNUmBEXFlB8yeUJr5+xvQ
 kZdBj+hD4nvoQ==
Message-ID: <8f48a9f7-f48a-0f2a-976d-3e9513a6c97e@kernel.org>
Date: Thu, 19 May 2022 19:32:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: Gabriel Krisman Bertazi <krisman@collabora.com>, tytso@mit.edu,
 adilger.kernel@dilger.ca, jaegeuk@kernel.org, ebiggers@kernel.org
References: <20220519014044.508099-1-krisman@collabora.com>
 <20220519014044.508099-6-krisman@collabora.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220519014044.508099-6-krisman@collabora.com>
X-Headers-End: 1nreOg-0093fd-B5
Subject: Re: [f2fs-dev] [PATCH v6 5/8] f2fs: Reuse generic_ci_match for ci
 comparisons
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
Cc: linux-ext4@vger.kernel.org, kernel@collabora.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/5/19 9:40, Gabriel Krisman Bertazi wrote:
> Now that ci_match is part of libfs, make f2fs reuse it instead of having
> a different implementation.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
