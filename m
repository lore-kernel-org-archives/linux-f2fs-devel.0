Return-Path: <SRS0=IVPH=Y6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D20EC5DF62
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  6 Nov 2019 03:36:00 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5741A2077B;
	Wed,  6 Nov 2019 03:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ZR8Dptx7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="B4Wafk90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5741A2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iSC6x-0002ar-Bq; Wed, 06 Nov 2019 03:35:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1iSC6w-0002a3-DL
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Nov 2019 03:35:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LbWGdNBAeDe9NI4vUkld1Bfqo0sjzcyiRxPvuPkAGiI=; b=ZR8Dptx7prIEUWS5hNozaLdg26
 yJbrbBdbt3J723bpu8ao5ixBgRhrC7J1l5zuxnarjd5bJ3NWUffxkI308qk+/labrXr4ifSiTn0c3
 rC0ffhlyY1Qf+ipidoYWJ3Ig9Yz+A1o2kdcIdYFVCdnasfXWWwLajXf2mM83QXGMt8FQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LbWGdNBAeDe9NI4vUkld1Bfqo0sjzcyiRxPvuPkAGiI=; b=B4Wafk90Uvq4Ck7kQg9wdNEo5U
 GAW99/lmuPvI6PI5v/rNxJZdm4vI+rj16QrSDX+DcgJZ2LlwMTLyftrsxJ9aqdcCTiH3bOfrF4jMb
 LShkqqXgsBwch8KHUwM1rTHhu413N2FtHoa1815WaJTF7vOFWN9ezl6+5M/TSVD7v07Q=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iSC6u-002HSA-Oz
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Nov 2019 03:35:58 +0000
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com
 [196.52.2.12]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA63Zk2N030405
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 5 Nov 2019 22:35:47 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id 615B9420311; Tue,  5 Nov 2019 22:35:44 -0500 (EST)
Date: Tue, 5 Nov 2019 22:35:44 -0500
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20191106033544.GG26959@mit.edu>
References: <20191024215438.138489-1-ebiggers@kernel.org>
 <20191024215438.138489-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191024215438.138489-2-ebiggers@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Headers-End: 1iSC6u-002HSA-Oz
Subject: Re: [f2fs-dev] [PATCH v2 1/3] fscrypt: add support for
 IV_INO_LBLK_64 policies
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
Cc: linux-f2fs-devel@lists.sourceforge.net, Satya Tangirala <satyat@google.com>,
 Paul Lawrence <paullawrence@google.com>, linux-fscrypt@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Oct 24, 2019 at 02:54:36PM -0700, Eric Biggers wrote:
> @@ -83,6 +118,10 @@ bool fscrypt_supported_policy(const union fscrypt_policy *policy_u,
>  			return false;
>  		}
>  
> +		if ((policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) &&
> +		    !supported_iv_ino_lblk_64_policy(policy, inode))
> +			return false;
> +
>  		if (memchr_inv(policy->__reserved, 0,
>  			       sizeof(policy->__reserved))) {
>  			fscrypt_warn(inode,

fscrypt_supported_policy is getting more and more complicated, and
supported_iv_ino_lblk_64_policy calls a fs-supplied callback function,
etc.  And we need to use this every single time we need to set up an
inode.  Granted that compared to the crypto, even if it is ICE, it's
probably small beer --- but perhaps we should think about caching some
of what fscrypt_supported_policy does on a per-file system basis at
some point?

						- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
