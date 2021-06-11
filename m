Return-Path: <SRS0=iRYr=LF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40323C48BDF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 11 Jun 2021 02:25:35 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FFF60C3E;
	Fri, 11 Jun 2021 02:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FFF60C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lrWrS-0002qf-VK; Fri, 11 Jun 2021 02:25:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1lrWrQ-0002qW-Ri
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 11 Jun 2021 02:25:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6SmDDmcHsiLQXQNTrX0A9KnFe0+5NlAMJUDIsFOyPjs=; b=b6rbNoNu8Y6XnakM9qt/sQANYg
 jUtRjB5D8pfid3Ik92vaUKfeE6mIMsF9hboNAbFZfbROXQn6MTSvZvB/5zNfSNkg9YI6USMIjhG/7
 yFcVmTL8YKGBpNQAupajMJ9xgjMjHZtwh4B+3+TzlRFurUrKYhoHcfgAn39nviiVFMyI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6SmDDmcHsiLQXQNTrX0A9KnFe0+5NlAMJUDIsFOyPjs=; b=gsZ4rSES8HeDhbwBX5KU+xAwty
 wWzDhf1rgKRUTKC9EJVu7kiQctmSd4a0+i+A6Gtg6Wx5BDHQszyB7dD6vnsV32rnfhznl8DE5gjYE
 1aljvZmRgaSV5g0HiXl4sRwXRE9FS8oTf1TpAiLk8GOqxEXoHIhYilfTnkX9WrtdE3+8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lrWrR-004Lyk-H5
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 11 Jun 2021 02:25:32 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 253BC6124C;
 Fri, 11 Jun 2021 02:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623378319;
 bh=j3FDr9xnJcCgR07zql+OK4VkeLxdJj8Zl8SGv4olxds=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V4msDiLz9LmE5aELx0LYd9HBwB8gSJ1pfSUBRfhmsPE9KQ2VrI0Uo5x7cCMwraUHJ
 9Y2xxRkPxwjrVLLakCttfFnNm4yKxj8GDTcfVk6f+gFb8B+EADbCNsyntlOJ5/oi/Y
 uXmzvZmi2MnPhuv/n0jgg1NhC+hO8HOdXJEyc0tSd4rwzEeW0v3knLq9S7qaZcV5um
 Q4ZqJGlKsoy1gMy/v07LBIIhG58rtWVl0YTxazLLHZOJbVnfxaIWxpCaeWsawnViAZ
 5alMaKoRg70mfjdFbWtRDcHDWhYvlKiGHQXE5aT/NS1Pgbe57kpajo9NF2s31eLTTO
 jovtxVxNjtAGg==
Date: Thu, 10 Jun 2021 19:25:17 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Message-ID: <YMLJjT97wHh4XJiZ@sol.localdomain>
References: <20210605075033.54424-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210605075033.54424-1-ebiggers@kernel.org>
X-Headers-End: 1lrWrR-004Lyk-H5
Subject: Re: [f2fs-dev] [PATCH v2] fscrypt: fix derivation of SipHash keys
 on big endian CPUs
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
Cc: linux-ext4@vger.kernel.org, stable@vger.kernel.org,
 Daniel Rosenberg <drosen@google.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Jun 05, 2021 at 12:50:33AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Typically, the cryptographic APIs that fscrypt uses take keys as byte
> arrays, which avoids endianness issues.  However, siphash_key_t is an
> exception.  It is defined as 'u64 key[2];', i.e. the 128-bit key is
> expected to be given directly as two 64-bit words in CPU endianness.
> 
> fscrypt_derive_dirhash_key() and fscrypt_setup_iv_ino_lblk_32_key()
> forgot to take this into account.  Therefore, the SipHash keys used to
> index encrypted+casefolded directories differ on big endian vs. little
> endian platforms, as do the SipHash keys used to hash inode numbers for
> IV_INO_LBLK_32-encrypted directories.  This makes such directories
> non-portable between these platforms.
> 
> Fix this by always using the little endian order.  This is a breaking
> change for big endian platforms, but this should be fine in practice
> since these features (encrypt+casefold support, and the IV_INO_LBLK_32
> flag) aren't known to actually be used on any big endian platforms yet.
> 
> Fixes: aa408f835d02 ("fscrypt: derive dirhash key for casefolded directories")
> Fixes: e3b1078bedd3 ("fscrypt: add support for IV_INO_LBLK_32 policies")
> Cc: <stable@vger.kernel.org> # v5.6+
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> v2: Fixed fscrypt_setup_iv_ino_lblk_32_key() too, not just
>     fscrypt_derive_dirhash_key().
> 
>  fs/crypto/keysetup.c | 40 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)
> 

Applied to fscrypt.git#master for 5.14.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
