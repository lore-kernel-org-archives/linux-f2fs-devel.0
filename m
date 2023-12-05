Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E52DC4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 Dec 2023 01:28:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rAKF0-0004Yl-JU;
	Tue, 05 Dec 2023 01:28:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1rAKEz-0004Yf-HK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Dec 2023 01:28:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=glksAfyIwPI7jwj4ucNcHi59RIxG7EDhQ+sEJVeUTCI=; b=N2LEx24Em6Qha+yq9q1/2WuvGU
 oNE1OGoa9ZU5BfdtwQMsUCpu7G90mzrTh91oz4yry8NWOWId5+2i1HLiadqjIkCHnMIj0ltFP1vPr
 Wm6cA+6qtePArQdpqGGBTd99uexpqgOIqFEZHr/JmMgzTTC18RgpdXAt9AD93j8vWpX8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=glksAfyIwPI7jwj4ucNcHi59RIxG7EDhQ+sEJVeUTCI=; b=lXbDccTVVfpS3hjwlkjvwifOAD
 WFPM1zkZ7o9hk1VfNHaxlzbaT6ff367ZdlA5mCubhXXfND0En9Hrpc5nA2uql7thoCuppKKzpk4fN
 OQzFrPJV3Pmaj4WRPFn01EM0HHCTCIyGiGmnQ8QWcknluhzJ3gKx1QGsR6opfaRdJETw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rAKEz-00084Y-72 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Dec 2023 01:28:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C9E67614A1;
 Tue,  5 Dec 2023 01:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5F7C433C7;
 Tue,  5 Dec 2023 01:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701739713;
 bh=L369r6QG+1soJZ/sl7HyL9wmEkarV3L7SQPXkpSpAD8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z4+avRTqadCix0I52N1G9GAJ1/JvqMmqAyXFykcz2aOLy7BDAttc2R6jB7ENY9l8l
 lZzHtJZGQFAsG4RclyT+uGsYYCoz+o4EkvjxRfp3eDhpmLvC6/QQEliLW4RRUT1yQ9
 xxpyaqoH/nxQlgxP2xdmwgpZK/b/M/BB0QU9LhIJhOtYPliFXRzVTPRGQAI8ExXT0D
 Orlvgq0u8JWPkJLAOt7P/11SgMED8HRp15G7vsEXAWyK2h8PFSPSHKy/1snNbzoYtp
 0wJTIZqdGgx787/sDySjSpG97+PmgPsqBcy6vNduWBGDcJ3QRkRt8K/9faTb62lFdL
 cOUZLkx0emk6Q==
Date: Mon, 4 Dec 2023 17:28:31 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Daniel Rosenberg <drosen@google.com>
Message-ID: <20231205012831.GA1168@sol.localdomain>
References: <20231204234615.3592624-1-drosen@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231204234615.3592624-1-drosen@google.com>
X-Headers-End: 1rAKEz-00084Y-72
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: Restrict max filesize for 16K f2fs
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Dec 04, 2023 at 03:46:15PM -0800, Daniel Rosenberg via Linux-f2fs-devel wrote:
> Blocks are tracked by u32, so the max permitted filesize is
> U32_MAX * BLOCK_SIZE. Additionally, in order to support crypto data unit
> sizes of 4K with a 16K block size with IV_INO_LBLK_{32,63}, we must

{32,63} should be {32,64}

> +	/*
> +	 * For compatibility with FSCRYPT_POLICY_IV_INO_LBLK_{64,32} with a
> +	 * 4K crypto data unit, we must restrict the max filesize to what can
> +	 * fit within U32_MAX data units.

FSCRYPT_POLICY_IV_INO_LBLK_{64,32} should be
FSCRYPT_POLICY_FLAG_IV_INO_LBLK_{64,32}

> +	 *
> +	 * Since the blocksize must currently be equal to the page size,
> +	 * we can use a constant for that. Note if this is not the case
> +	 * in the future that inode is NULL while setting up the superblock.

I'm not sure what the last sentence is trying to say.

> +	 */
> +
> +	result = min(result, ((loff_t) U32_MAX * 4096) >> F2FS_BLKSIZE_BITS);

Is it intentional that this is off by 1?  If indices can be up to U32_MAX, then
the maximum size is U32_MAX + 1.  It's not a bad idea to go with the lower size,
so that max_index + 1 does not overflow.  But that's not what the explanation
says, so this seems to be accidental.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
