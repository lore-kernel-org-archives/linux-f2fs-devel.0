Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294A2C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Jun 2022 08:14:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o1OAW-0000sx-6u; Wed, 15 Jun 2022 08:14:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1o1OAU-0000sK-Up
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jun 2022 08:14:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y6av2URRNhh5M4u8ufGX07nGfx9pPD7LIHfDe8l+mfE=; b=jQSH+zMaPU+E1cFT7gfflK0v2B
 15a0RvZPDq80T8LTy85x4RePK32Ys73cBJe9VVHG7oaiNNaxVaKf6pA/NaAbp5Dc8MkU2GztDkLEU
 jIcPaRSkO8jjAiK9IV8U8AwD0YsqDPma18c63ETpMf5mifh8rcaEoLwpR/K9gSAZ49lw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y6av2URRNhh5M4u8ufGX07nGfx9pPD7LIHfDe8l+mfE=; b=kl/i9gD28/FZLD1jOrpUfmdm4d
 dIxeu9OeMlriOprvDfqSuy2ZLhCSaFr4JyPx1MQYP4TfUB6kwBHye3ky04iPfMJzbYWGtn3QwfwIC
 q+34MNIxR4s/qsRKflHIf0vGmQVScvbkdYWv24H4ALJdGGUsFZq5rn30ucP89gjknuTU=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o1OAQ-0005AM-5x
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jun 2022 08:14:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 37B21B81CF6;
 Wed, 15 Jun 2022 08:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82B7C34115;
 Wed, 15 Jun 2022 08:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655280856;
 bh=k+3SUrAPzRklM1OSV+O/gZAPfDFx88kiFdDt9TP8wi0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=t5unw6qXFjXOZXP3wCnQaVCCZRKnjr3Y7yDD2CCdvPV0FgCG0ZLsOu91d+vP0jN8z
 fmsHRt4/NdxKkEzsf/E6WIZCC7GTcM6NfrbhS9Dz053s2pzeGosoG4/R//xZBa9aDV
 eFh8WtHkVtDTZ2VE/hmqF/sZ1gr8DjkHI9ZAl5d+elWRdNudKVDbMD2ohPrjCQPuvo
 V4oVDwMuUanM4M3NjQvbKBGCN+3dpLTTVSGBr5OEIvX34y2mvIQT8c9GxIzABbihT9
 bLKhsokce4riUp5mQRw77bqwDdnJ3CEi+CEiZVVeIyEwtpdO+AUGC5cMmTspYWtUqZ
 C8r+3BE454s5A==
Message-ID: <c4db5f98-6b00-99e6-ecf2-63372f20c516@kernel.org>
Date: Wed, 15 Jun 2022 16:14:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
References: <20220605193854.2371230-1-willy@infradead.org>
 <20220605193854.2371230-6-willy@infradead.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220605193854.2371230-6-willy@infradead.org>
X-Headers-End: 1o1OAQ-0005AM-5x
Subject: Re: [f2fs-dev] [PATCH 05/10] f2fs: Convert
 f2fs_invalidate_compress_pages() to use filemap_get_folios()
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
Cc: linux-mm@kvack.org, linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/6/6 3:38, Matthew Wilcox (Oracle) wrote:
> Convert this function to use folios throughout.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
