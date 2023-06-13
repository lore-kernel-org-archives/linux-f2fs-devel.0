Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FA5C7EE2F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Jun 2023 00:45:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q8sAN-00036E-Ki;
	Tue, 13 Jun 2023 00:45:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q8sAG-00035e-Dl
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Jun 2023 00:45:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+dCC17VE2p1T4RXAfPDrSMl77Wi1nF99FHA4W0UgQvA=; b=momJjOBY/NpcEtep1V5Tq/IThM
 Oi1xIHkHy0O2zP1VYnvHpJRwkU014jb0Arf08Ua5R+SkznPY31EcEK3ufjPC+wsuAtu5mDg2TVGGl
 lJttq/JGvh+ID4NRLMSSdxezqkYECPhiDdXCMEkprl3ma/qUpvTW5cNkqnzk2mCy4pYE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+dCC17VE2p1T4RXAfPDrSMl77Wi1nF99FHA4W0UgQvA=; b=ihhDbLMurPVO3t/CXRJ+1fdBUX
 CWkvsoYWdPSQk7LYGhUGp31wsE8i0KAF98mOwhIeUflSKk70+5PJSaWhxFm5Mh++mwgAC6M/qrVkq
 C6kRh9fhNoXDhiegImxyVx6C1qmDQfVTRO75zsF0+/7weL67rmG9k0eiHHTMmIjOX0xc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q8sA9-0006KC-BB for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Jun 2023 00:45:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8440162A89
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Jun 2023 00:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375C5C433EF;
 Tue, 13 Jun 2023 00:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686617121;
 bh=eFkokBRn7jvPbmEIYaLNA1SVW4wN9lOQvNF/OeMvoFg=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=ArllJx54DLzD1TeRGUZOnBIcE5S3MjymuzHypXbwscaR2H9u+r+nLbcNDzUHrsDup
 mgp3b/W2fUUTZDtK6iHrLP9OsZjQM440k9V1SyvgEg0zkgbhhA/gY7Mh/9yQeMTu0E
 X2xtrrWAyr+/PFoP9JtS5dedJKGJwkj0RjoSy0Q3dyt9gdrRI4siHe2G9MjcqtgSy9
 cWIu1YLuyZuIyH8ZS5tmMPn520h8i8Tps66L+Rl/sggKnUjvObzjDbFNyaZaMqN2VE
 Sy4bcgKrJdZ/dyyJyNsMrEbmnL5I7wmcM0o1GHpKRQEc/mUm+jbpzCngUUgdYeS3Qs
 WyGXzgy2JP9OA==
Message-ID: <d92516e1-2eed-c46b-78a0-4a93573c0ed7@kernel.org>
Date: Tue, 13 Jun 2023 08:45:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20230607162954.2651657-1-jaegeuk@kernel.org>
 <ZIc28R76RSEC6uo1@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZIc28R76RSEC6uo1@google.com>
X-Headers-End: 1q8sA9-0006KC-BB
Subject: Re: [f2fs-dev] [PATCH] f2fs: set zstd default compression level to
 ZSTD_CLEVEL_DEFAULT
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/6/12 23:17, Jaegeuk Kim wrote:
> ZSTD does not support compress_level=0.
> 
> The commit d7ffafc99c42 ("f2fs: add sanity compress level check for compressed file")
> started to complain this.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
