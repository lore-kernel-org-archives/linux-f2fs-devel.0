Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BEFC43334
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Jun 2022 13:21:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o40IJ-0006Ad-Ml; Wed, 22 Jun 2022 13:21:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1o40IJ-0006AX-3o
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Jun 2022 13:21:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XPeefldeWzVHWZ+odjgCZnRDW8+RxfcMoP983LsW+k4=; b=EORGco0YHcjlJsEB5JQfSt3OFA
 uonym5Fm/4zrRYftZRg39egOU9a1RPK91VU2iV6shs020nbMrvRV1FDuZLOp6/WnAFeXJuZ8ZSEwZ
 6Lc/6TGbeSVvdFNq98665EReZEshTUYsVRWsrCspaMNYUdUmesGjJwrgPU33OytDHErE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XPeefldeWzVHWZ+odjgCZnRDW8+RxfcMoP983LsW+k4=; b=khP0O5whHy+D45JvIoZUKDo4EJ
 9v2y92Fk7ONu6h/JXfKyTz5Kt7j8SwP8YhzTrrJl1V9SQWzMiytOFDV2AJxqX8k4OqKw+dZdTOQfT
 eY/AA0WukMfr+6lRz1Xfry+kYwjaKlr8U990C4RiD4vrUZTvV6Au+mUg4fvJd3G5BQaM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o40IJ-0002Ta-8N
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Jun 2022 13:21:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D643661A39;
 Wed, 22 Jun 2022 13:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FEBC34114;
 Wed, 22 Jun 2022 13:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655904073;
 bh=XPeefldeWzVHWZ+odjgCZnRDW8+RxfcMoP983LsW+k4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BZJXRsYxOVmdQeiCNS9zsS87ptVZ+z9ATiduX6Y7eh8IPiEFCkNlgh5FAap/I0yB6
 c0ScG7ud+SQsrVEYVuz4N6wtNHZFj7gb8Thny5vMudxOINJqHVxLSBGPvNpPEOxhzv
 IUU4ak+76hDq5W9zwlcChscIx33Yv1wi9iIke/RD6+FU78ZBhIdrwbBe+eC6Tntk9n
 W047yXuUzy+QpTEzbOBdSWTDS2WvyPdhymL3kAK5Bav2UqW2r4FX5hkmMciN0U5Fx+
 gV5QfsEn7ZcB66BiYiRMoitodVPyVvTFcRHI/DNCXD0nA1XiOSk5eW9/YDNkXSXywX
 dTTGkid4W2F3A==
Message-ID: <b4861302-a4bc-9022-c1b3-084f16d8ee87@kernel.org>
Date: Wed, 22 Jun 2022 21:21:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: qixiaoyu1 <qxy65535@gmail.com>
References: <5627a654-d605-6840-a133-e583c804aadd@kernel.org>
 <20220620115629.9169-1-qixiaoyu1@xiaomi.com>
 <20220620115629.9169-2-qixiaoyu1@xiaomi.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220620115629.9169-2-qixiaoyu1@xiaomi.com>
X-Headers-End: 1o40IJ-0002Ta-8N
Subject: Re: [f2fs-dev] [PATCH v3 2/2] resize.f2fs: update man page for
 options -i, -s and -V
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
Cc: qixiaoyu1 <qixiaoyu1@xiaomi.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 liuchao12@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/6/20 19:56, qixiaoyu1 wrote:
> Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
