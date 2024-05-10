Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB34FC25B74
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 May 2024 01:26:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s5F1W-0008VZ-83;
	Fri, 10 May 2024 01:26:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1s5F1U-0008VJ-FO
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 May 2024 01:26:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IUYKJomxQcYaKARLTAm3ZNtqGYCzcs80nrnR6D/gUpg=; b=K0bEUzCzCv9AgW5qaANzRc7p/c
 JsMVAcKtP+rntwXYfiYuI76MmccZpt/ioZ4Sfitd2ahSjGQ5xAfKiqWcs6SpuLPxr7/GqvLCizA9g
 r5toxnu9pmIflgKfy6gtA4nrqaqqV7J+yPBdV7itBsErMaD6hjmbmD9y4XtgWtWg7/WU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IUYKJomxQcYaKARLTAm3ZNtqGYCzcs80nrnR6D/gUpg=; b=GUuA4jDiRZPNa6h0hhc9AeSVdb
 wnV+UM4PPZG3NgTVctCxbyNrY2htpYGyU2wKJd0FLMVPLJNMX3A+kO8leo3cIX9KcJZwi+KNl5smO
 UO0V3zXiyL35ThUOmm8uxxG9yjfNyeoggl9L7XMoTfidvizVIXr7ffn399cFwLlI+DWs=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s5F1U-0007cR-PZ for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 May 2024 01:26:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 49B2DCE1C62;
 Fri, 10 May 2024 01:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0DAC116B1;
 Fri, 10 May 2024 01:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715304355;
 bh=Yu7c1ifrsrVOFyS9oevLBygV88/BTD88Mmi6Ca8A52k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QsVeC5/bO7SkLYnTpKSD+ulUFB67gVQ42OQV4Rtb5NkMyjHLhcgDH2FPHDPSRdPpB
 2vANBlmZ4lVrxm43+uAL16ppLssifZz1ueIgruCT2lwWS3y2mXTuGEBy2h1lir+rdv
 INxwSRdJfw9GETkEe/SM3y+RiKT5PGf+B+bA2Eh2EsTKj4uYg2b5xZ40RujAzlXkKO
 8I+TqXKYoHRYn9C4vHTOaLyoEYHAAf+zwogWyhOVJnJIg8RkqrOKE63WDTNQ+VA169
 6gNw7MKmaxrEAGDobMw2L354gG6+dYXP5ylyt8aGnXK80VeseYmfK9N+Qk+yd6dnII
 hhL2pWuVKVcaA==
Date: Fri, 10 May 2024 01:25:53 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Message-ID: <20240510012553.GH1110919@google.com>
References: <20240405121332.689228-1-eugen.hristev@collabora.com>
 <20240405121332.689228-10-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240405121332.689228-10-eugen.hristev@collabora.com>
X-Headers-End: 1s5F1U-0007cR-PZ
Subject: Re: [f2fs-dev] [PATCH v16 9/9] f2fs: Move CONFIG_UNICODE defguards
 into the code flow
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
Cc: krisman@suse.de, brauner@kernel.org, kernel@collabora.com, tytso@mit.edu,
 jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Apr 05, 2024 at 03:13:32PM +0300, Eugen Hristev wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Instead of a bunch of ifdefs, make the unicode built checks part of the
> code flow where possible, as requested by Torvalds.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> [eugen.hristev@collabora.com: port to 6.8-rc3]
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>  fs/f2fs/namei.c | 10 ++++------
>  fs/f2fs/super.c |  8 ++++----
>  2 files changed, 8 insertions(+), 10 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
