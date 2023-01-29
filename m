Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AA4C61D97
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 29 Jan 2023 09:58:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pM4Rh-0005b5-Mh;
	Sun, 29 Jan 2023 09:57:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pM4RJ-0005ao-0C
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 29 Jan 2023 09:57:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TfjOBIxSoroSo3zURILS6SaIC8MWvAC2330cEREXtKE=; b=Bazn0r5+IwdcuJyQPCcDiCd2uw
 uVPhL6bd+zgCOPf9YEIFfBrW2VVK1dupjauq25YF4CiF+U+MKoR0PpkUDCMEtoXHYENSp8gXqe6IO
 029e7T714vQ0HQo+NBsBXHhxE3NhVTI54WbPBFPywe4Aur9II0iVmwds5WImE2gUM6/g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TfjOBIxSoroSo3zURILS6SaIC8MWvAC2330cEREXtKE=; b=lPMKzP0xdMTuMcDdCf+SN2HAcj
 Nx+ksw7Woc1KTGttRlicNNdrpI20RHbfa28NOaEvfbuX/DzOiKtxAfsbCFkkvFvtSjxZhL1ZzV75p
 pp/QGIY0v+t8Xg/HyAiGYA1Yc0wSOHWT8rXvFvCwR3/Bzg8m9FC2o59pNJ9zs67ikAUc=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pM4RF-00060t-MA for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 29 Jan 2023 09:57:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 99E50B80CAF;
 Sun, 29 Jan 2023 09:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85A1C433D2;
 Sun, 29 Jan 2023 09:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674986240;
 bh=apEDmRZhX3hyzHCBx6zt5RDKOOhTd7PNbo0vhXbka+U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UkfyTI69OqX/LaUwiUjTKbaYkYGuLR8zZ0+TgaR+4jpF87E7NlZGOtol74V/ByaX5
 gAVp1hIpdpmSj9xOaAtH2YOVXj/C9I6yfgmVqjGGaU00QRhcEAuNAZ4cCEEUbgX3n7
 y0WBep9b8TAbl2NFr4Sh6WdRrvHA0k1PbKCBD3S8espeYklhnMFpvogXFxU0xpN9mn
 kB/Ep7v2xIqAJTp0+xyI9NnaV4gBKDHYSbKe5pQD35Ly+M4pXHYO0yXzmUb098i9nn
 OWhJCkF/gANHHA+p4wBK4qKazZbB8xxyEQAwPMe0RRvX6fsMvMlkOORrWYCUqZQjUt
 BGjk+um2ph+tA==
Message-ID: <fc687ff5-9663-0f80-41d0-f9668c743602@kernel.org>
Date: Sun, 29 Jan 2023 17:57:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230123070414.138052-1-ebiggers@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230123070414.138052-1-ebiggers@kernel.org>
X-Headers-End: 1pM4RF-00060t-MA
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix information leak in
 f2fs_move_inline_dirents()
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
Cc: Alexander Potapenko <glider@google.com>, stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/1/23 15:04, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> When converting an inline directory to a regular one, f2fs is leaking
> uninitialized memory to disk because it doesn't initialize the entire
> directory block.  Fix this by zero-initializing the block.
> 
> This bug was introduced by commit 4ec17d688d74 ("f2fs: avoid unneeded
> initializing when converting inline dentry"), which didn't consider the
> security implications of leaking uninitialized memory to disk.
> 
> This was found by running xfstest generic/435 on a KMSAN-enabled kernel.
> 
> Fixes: 4ec17d688d74 ("f2fs: avoid unneeded initializing when converting inline dentry")
> Cc: <stable@vger.kernel.org> # v4.3+
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
