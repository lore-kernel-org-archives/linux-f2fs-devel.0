Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E22CAC5B8
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Oct 2025 15:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hGwAy2v+aGTY5tM57DPSY/vIpgcYRQPu1iougmqawWc=; b=Wr5Mm8W2cCmGQPt7SU+OH3Bizd
	r5zgWZavRblifB9q7bIzCfnA4muQKe1ECWAkHo4LBu+z0pqSMrvSibBV3jLx2n3VIWqK6dt2UFDyu
	EGfvv9m1TLuU5m/+T2at1/Rnhdlj5hrbvp0S3zhTIItmVkjc3BejR0QRL8XBzCAOrvpQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v5nP2-0000DX-Op;
	Mon, 06 Oct 2025 15:45:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1v5nP1-0000DQ-J2
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Oct 2025 15:45:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5LhZrJlJHjchCDvSKJkGecWKI7XV3m6Ufv49aVHRgXk=; b=ExchPBFQnKCQfPgXlFqkOsEUNv
 KoYNYVIQnLH2o2NdIY1unzxfW9nk1Fd9MGBgSNSR7zOEzX9gIHggmFILA3uWJ1AL+AlHKk5lB9OB5
 oLMoVM0wsztR50IoGaS/2qV75xx28/DoElJzvwIm7eC4EvS7iMGM0NUFOXAqJ+gsdN2M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5LhZrJlJHjchCDvSKJkGecWKI7XV3m6Ufv49aVHRgXk=; b=famBr9ES9Nl0q6nS4YaZGg0M79
 vzeniIYNo9SC+H+HQd5RemlKRrq3FUVPRL8wnGXLMYtkwtVJVNhsoo3imkAiYTZ20wEWBSEMiP16F
 UZQ3R6n6S7UspWIRVi+DeQRC0pFgsfjJFbKvtRDCf73IufvMs4veqIWHYe7nOT0tnivI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v5nP1-0003Na-2V for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Oct 2025 15:45:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 618F360575;
 Mon,  6 Oct 2025 15:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0783C4CEF5;
 Mon,  6 Oct 2025 15:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759765525;
 bh=ZCWd7FVJLQKznwNuy6v4DA8xIEx1VeEVA2yjWmyUQUA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N1STMmfkqsitLRvr4uQFMq+zOGDhpoypKWBdx8cAFSTxmk3hPsCc26TubK9EipmGh
 q8HmwpX3XC77ROd6mxfXZX9STpPS6wK8I3Q0W9Pp/VEDQPTMIuu1EkCAJL5t7Oc/og
 4YfUbzUMzIwDiYTA1dW/Rk2S0jRwfxIGIQgMouxZrIW+EzB5Wn5n3EskpBhdBs29uk
 AVnfcmHp6rmz29BT6Q9mgdHNdRdh1yjgsaK44fuUdDpMNk3Xfa/UybQSl1qSnPIaJ7
 MTdVPO2NRX9UR6SZmHFVykkAA8hRu3bvDsPubIfFY2ezQZVCIIRPwuua5KP588qRxK
 FmjXkqQgpDr5w==
Date: Mon, 6 Oct 2025 08:44:01 -0700
To: Jan Prusakowski <jprusakowski@google.com>
Message-ID: <20251006154401.GA1637@sol>
References: <20251006095813.3497619-1-jprusakowski@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251006095813.3497619-1-jprusakowski@google.com>
X-Headers-End: 1v5nP1-0003Na-2V
Subject: Re: [f2fs-dev] [PATCH v3] common/encrypt: Explicitly set the test
 file to uncompressed
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Oct 06, 2025 at 11:58:13AM +0200, Jan Prusakowski wrote:
> verify_ciphertext_for_encryption_policy() checks if encryption works
> correctly by reading encrypted file's contents directly from a block device and
> comparing it to a known good ciphertext.
> 
> This, however, won't work if the test file is also compressed. So this patch
> adds a check if a test file is compressed and disables its compression in this
> case.
> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
