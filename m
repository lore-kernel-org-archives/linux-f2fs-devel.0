Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11361C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Dec 2022 14:36:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p3I12-0003WS-D8;
	Thu, 08 Dec 2022 14:36:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1p3I0x-0003WH-K0
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Dec 2022 14:36:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IQ9uIxiL4xsH2wWh6xMcdpzaMYzwTIFYJjr9XqCgP+8=; b=NYxw9XxvDs2ggm8R9zyztbiNVs
 BKkL1GS5NuVzHRCyXgMxkP7oufqB4hGxp7suZ9kksHnhngve9F4PSvkxOyQDmkkgaM3Ky9eUs2Cl9
 V97m9nHjs/MSpWdSF8wM7uT8P0KFOdbigArnm6jJlOdw0IX4USOq5Ot9Csu1zsVH61BU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IQ9uIxiL4xsH2wWh6xMcdpzaMYzwTIFYJjr9XqCgP+8=; b=nID2ZAtYH2xH4hc5Ry66178WLt
 naBLCk3KW+dlbbjkdrVC+FyJSH25s00xoWMes74MvfOrK0H+KOjD1jI5xpiamNuZfhSihg7EYFux4
 2Dl/5sZKWxNDKzOCL6wGLM6KhFetuKq/5NZtDUGIw5AEx41dX5eYHpDQTzFwrmJUG5jo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p3I0q-0007bp-FO for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Dec 2022 14:36:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B60A261F6B;
 Thu,  8 Dec 2022 14:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEAAC433C1;
 Thu,  8 Dec 2022 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670510190;
 bh=wtl2uDEgxBI9G6G421QCM+ypUTt/sVo89TxSalU2Bao=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IH9kw0BRb4FBaVLi6TW8GD281AnyEhTg+xNC6u1JwaEeuP7oTy0IeuJUfyB4DCDd0
 m4XyTNXv0vJi6zHf96pFCO+L1sSCT8UsMhC8glIXBeJB13+Tu4De7zTQkOosQfWMBu
 YNAkkru41vxUyMMet///BZY9YssIxD7V/N5qoNvXCQnfazUsSstOhOKmg8WRpq+iko
 RJptCseuZLU6dH+vZ4Ka3/2JgSjrBSAiRg/r9sUpaY64wchmxcAXef+gtV2C4Ougjr
 V7mCAsVYjUzvRw61brwYEHaGoB7LQifSIckgIbz8dBs2OQtJ/ctWamDWCYULrLwizQ
 0Q77I7gbonxYg==
Message-ID: <414f53dc-b14c-0be1-8b5b-50227b65d448@kernel.org>
Date: Thu, 8 Dec 2022 22:36:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20221128094346.1256688-1-hch@lst.de>
 <20221128094346.1256688-3-hch@lst.de>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221128094346.1256688-3-hch@lst.de>
X-Headers-End: 1p3I0q-0007bp-FO
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: open code
 allocate_segment_by_default
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/11/28 17:43, Christoph Hellwig wrote:
> allocate_segment_by_default has just two callers, which use very
> different code pathes inside it based on the force paramter.  Just
> open code the logic in the two callers using a new helper to decided
> if a new segment should be allocated.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
