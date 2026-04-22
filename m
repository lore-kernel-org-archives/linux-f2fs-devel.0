Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A45FAD3E1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Apr 2026 23:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A9QzNyEk5l5tO1PgfHITWLw8ftN+i+/VokEgGnZUAqc=; b=CGioCYJjqLdSRZD+NKDJsgYl5w
	ZMvSpKxjgxiQ8ZwaVgeZBMdxyGpURnIiGeOJjJZxb0gkAKI+6PhA2vuVESLIqapOcM3zQfp+MbxFn
	H3EDeAQBmDhFM6PjcEjwbzNOCJZ4jkJA4VuX4SRQCM3HbnUt3Z2+X0Wg9s/9H2dbDub8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFh0I-00013c-5a;
	Wed, 22 Apr 2026 23:29:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wFh0H-00013T-5H
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:29:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6wFPiIH5ex67Fst4LcSGjEjPi/jgihMu71AWUJnOCtA=; b=Ha9CziZKuGlGST5nptfX893IcO
 NDchD6x7jy220lC9aEWd9DAb/D27GELDvgfSNeg2laMEZGuhY11GZmbAmAjuH6IiDhknLMerC+yau
 kAh6RozvYgks8anUu04GeNIVXl3tdzSVuMxOrNqEhA7hKrvD1w5/DPm8fN3JfZUowv+A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6wFPiIH5ex67Fst4LcSGjEjPi/jgihMu71AWUJnOCtA=; b=P/dnJWoBW5psoQ9Fz/QyjFL/vC
 aTr0zY8vW5n/o635K4xDz18Rkp0GHjAuP1ZsDDRz9kimEsw386f8kiWup5IhXZTUuWnHQisBR1Oje
 HujkZERj39tqAmm20PI4TfSKxEzu4RbUSg9GWoOcJbGMw507DEo0fN9nUc+2DMrgx1Q4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFh0G-0006Y5-LG for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:29:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5081540E56;
 Wed, 22 Apr 2026 23:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC915C19425;
 Wed, 22 Apr 2026 23:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776900543;
 bh=bvl92UEOxoPlURu3laZ0+Grpbq+E+dKoVy+MV3iNcMc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SekkEjDhHV8mJkGXxThm7jzjXl5r+G21rFwehhvUlC8Rt0thUJXkQ9ZvnLJDA49bN
 AiEWsPZKrWpwJl6zfPjMan6ZQQZ0SAX+GPqfqhIpTcP35W8c1hY1j5dB6ZIVRdWyZA
 RNZviU5piCS25/nr/hQI6ts3ddvXVIovvSSX1VqyN4YbVGTBHe3cWBWDtY95rWDwN0
 xHHWA5ihxTGxv+YwxpMRqQ876Ka0u7IW76BymiTC5SP9o3smEjBbRycPC8NcfOLvHb
 0Z8M9tfGW58T0LF6vlXrNkCURDjmm/8i26jOGnEaqiBhh7H6sdLRr3wu5y+atVFtu1
 3x/J7bLZeZD7Q==
Date: Wed, 22 Apr 2026 16:27:47 -0700
To: LiaoYuanhong-vivo <liaoyuanhong@vivo.com>
Message-ID: <20260422232747.GD2226@sol>
References: <20260421075717.170840-1-liaoyuanhong@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260421075717.170840-1-liaoyuanhong@vivo.com>
X-Headers-End: 1wFh0G-0006Y5-LG
Subject: Re: [f2fs-dev] [PATCH] fscrypt: add software key support for
 filesystem-managed data
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
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Apr 21, 2026 at 03:57:17PM +0800, LiaoYuanhong-vivo wrote:
> Some filesystems store small file contents in filesystem-managed regions
> rather than in regular data blocks submitted through bios. One example is
> F2FS inline_data, where the payload is stored inside the inode node block.
> Such regions still need to follow the inode's fscrypt contents encryption
> semantics, but they cannot rely on blk-crypto because they are not
> submitted as standalone file data bios.
> 
> As a result, when blk-crypto is enabled, mechanisms such as inline_data are
> typically disabled outright. However, it is desirable to re-enable such
> space-saving features while still preserving the required encryption
> semantics.
> 
> To support this, add fscrypt_crypt_fs_layer_page_inplace(), a helper that
> encrypts or decrypts a caller-provided page region in place using
> filesystem-layer software crypto and the inode's contents encryption
> policy.
> 
> This support is limited to v2 encryption policies. v1 policies do not
> provide the key setup model used here, so this path returns -EOPNOTSUPP for
> v1. Hardware-wrapped keys are not supported either, since deriving a
> software skcipher key requires software-accessible key material, which
> conflicts with the hardware-wrapped key model.
> 
> When the inode's normal contents path uses blk-crypto, fscrypt may not have
> a software skcipher key prepared for the inode contents key. Add an
> optional filesystem-layer prepared key to fscrypt_inode_info. This key is
> derived using the same v2 contents-encryption KDF as the normal contents
> key, but is prepared as a software skcipher key and is used only by the new
> filesystem-layer helper.
> 
> Signed-off-by: LiaoYuanhong-vivo <liaoyuanhong@vivo.com>

I don't have time for a super detailed review at the moment, but here
are my initial thoughts:

- This needs to be sent along with the code that actually uses it in
  ext4 and f2fs.  Please also Cc the mailing lists for those
  filesystems.

- This is going to require an "incompat" filesystem feature flag.  After
  all, once a filesystem contains files that use this scheme, older
  kernels won't understand it.

- UBIFS and CephFS already use fs/crypto/ but don't support blk-crypto
  (inline encryption).  This new code feels duplicative of that.  It
  should be possible to reuse the existing code instead.  That would
  include, for example, reusing the existing en/decryption functions and
  the existing struct ci_enc_key field.  This would keep the changes
  limited mainly to how the key is being set up.

- Supporting all the different IV generation methods doesn't make sense
  when a per-file key is always used.

- The fact that this is incompatible with hardware-wrapped keys greatly
  limits the usefulness of this.  (Note that technically, it could be
  supported in combination with them anyway.  But the security models
  would be inconsistent, which I assume is what you have in mind.)

Hope this is helpful,

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
