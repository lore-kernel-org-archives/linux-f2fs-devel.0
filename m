Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0265C07E9D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Sep 2022 06:58:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1odnV8-0006OB-HL;
	Thu, 29 Sep 2022 06:58:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1odnV7-0006O5-Gg
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Sep 2022 06:58:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iYgbDhsmb5Hn95h/koDSj87xcRd2UTQnR0FB6TgsuAw=; b=NBHAW/aZrI8IyDo0ArcEDFOaQ/
 EzmRJQ4ePRpewp+HkCHndgj1Xy3utaVKj01GHF83hJKZpcyvx3TVoh34T/ZcF2vHMc7LsoaH7yhcy
 QxAHbj2CnQfLlPPYsPqOCllnJlnSCw5JLE0K8gRtqafeAwgcr8e9hk7TOIal3NjufraI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iYgbDhsmb5Hn95h/koDSj87xcRd2UTQnR0FB6TgsuAw=; b=alNg5VnrflMro9Cbyu+qmojYQ4
 KiksB5dkvS11XH5BcSBVAAHEfWKYKG8oOuzQgnfRU/0r8UvM+ZcVCrctyr2K2awh7F+iCxgcYAjLv
 VnnQdIq8hU7mJWXLhDUR3YgEeLOcT5aXkwIZYbS0R27nh3i9NBVwcoOQK7CmzDzB1FsA=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1odnV5-0003Ny-BD for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Sep 2022 06:58:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 953E4CE20D5;
 Thu, 29 Sep 2022 06:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA7EC433D6;
 Thu, 29 Sep 2022 06:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664434696;
 bh=48Yc5HgQmEVMfhl/617yDA7Og2HjBTpYuAiPgq/9KqU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=U8AcfEsTChMEnTKrDEy2bTMj3LFvM9IGogneaYpz5w3drMArm/k9aUcBZ1cAixD8s
 IjW+Rd5UJfjIuB9k5gtUJuzy4tR8hoUAgfw7HJZtdpReBRyBZ45GNH3Rrl8gIYllfk
 YixmJbUMW1rKMTtO2gXtlJaV4x9sSlH6To+IVcqytZVOAdsxlbvQtQM3dO48mK3XDd
 GrW/S/XizkwWGdyPPVu/pduFOofRVYFXgKeJEGIgesLABscADWXCiwMmzdSKHszW0v
 +DF2QGE1GLuGyXhTNt2O6xyuWNgxNNVNQFRDLdKb+2ZW2ffuljZqA8FRUlXyHkmicz
 6TGOdFz+hAMzg==
Message-ID: <e15cbc44-e227-39a9-38e3-9144f458a17c@kernel.org>
Date: Thu, 29 Sep 2022 14:58:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20220919160644.2219088-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220919160644.2219088-1-daeho43@gmail.com>
X-Headers-End: 1odnV5-0003Ny-BD
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: correct i_size change for atomic
 writes
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/9/20 0:06, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We need to make sure i_size doesn't change until atomic write commit is
> successful and restore it when commit is failed.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
