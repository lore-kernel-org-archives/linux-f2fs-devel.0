Return-Path: <SRS0=vASv=AF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55C3C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2020 05:43:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8757A20768
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2020 05:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="dRfIhpOD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="bduxOYUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8757A20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jnyC9-0008Sq-7S; Wed, 24 Jun 2020 05:43:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <krisman@collabora.com>) id 1jnyC8-0008Sj-6Q
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Jun 2020 05:43:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:In-Reply-To:
 Date:References:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xB+6J0O4jzl4NVJI8LmAon6D5LOR+VQ3DLNB2klpNMw=; b=dRfIhpODzevqDr0IYU5BPSc+Ye
 ORjlCAc8dQROhpR6MtndfAXvgVEaFlISd4NntK/ziUXeFI2pQu/4ZJaC/6yUBnaMTTihvuN1QCqEy
 Y4eAKuFKx/cjkwdox/ey9jISp3zP4Kdtmuw9k7aGmY8vpjEydEQoDvYiwBseuqolxW1c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xB+6J0O4jzl4NVJI8LmAon6D5LOR+VQ3DLNB2klpNMw=; b=bduxOYUDJKvy0tCzWNUSLitecL
 aXmRV5Dq+kKj3DH3OReGH8wM1FCuJJNZPjRVmNxDVvUcW0vMmX1/0gvLk0E5kXTcPYFhdwFhIn6Uq
 m22T0wmN3L7omauPC0B7T3PRQ8UT8mKH9YU+BC7L3TaN4gThagSVozKRXz+87g3DxCUE=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jnyC6-00GBva-NC
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Jun 2020 05:43:36 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id 640412A4015
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: Daniel Rosenberg <drosen@google.com>
Organization: Collabora
References: <20200624043341.33364-1-drosen@google.com>
 <20200624043341.33364-5-drosen@google.com>
Date: Wed, 24 Jun 2020 01:43:22 -0400
In-Reply-To: <20200624043341.33364-5-drosen@google.com> (Daniel Rosenberg's
 message of "Tue, 23 Jun 2020 21:33:41 -0700")
Message-ID: <877dvxggsl.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Headers-End: 1jnyC6-00GBva-NC
Subject: Re: [f2fs-dev] [PATCH v9 4/4] ext4: Use generic casefolding support
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
Cc: Theodore Ts'o <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>,
 Richard Weinberger <richard@nod.at>, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-mtd@lists.infradead.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Daniel Rosenberg <drosen@google.com> writes:

> -
>  const struct dentry_operations ext4_dentry_ops = {
> -	.d_hash = ext4_d_hash,
> -	.d_compare = ext4_d_compare,
> +	.d_hash = generic_ci_d_hash,
> +	.d_compare = generic_ci_d_compare,
>  };
>  #endif

Can you make the structure generic since it is the same for f2fs and
ext4, which let you drop the code guards?  Unless that becomes a problem for
d_revalidate with fscrypt, it is fine like this.

>  #ifdef CONFIG_UNICODE
> -	sbi = EXT4_SB(sb);
> -	if (ext4_has_strict_mode(sbi) && IS_CASEFOLDED(dir) &&
> -	    sbi->s_encoding && utf8_validate(sbi->s_encoding, &dentry->d_name))
> +	if (sb_has_enc_strict_mode(sb) && IS_CASEFOLDED(dir) &&

I keep reading the 'enc' in sb_has_enc_strict_mode() as 'encryption'.  What do
you think about renaming it to sb_has_strict_encoding()?

These comments apply equally to patches 3 and 4.  Other than that,

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
