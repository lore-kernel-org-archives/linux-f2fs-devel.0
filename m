Return-Path: <SRS0=Uf9r=WC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC51C31E40
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Aug 2019 20:45:22 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3B42070D;
	Tue,  6 Aug 2019 20:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="dE5wLvCt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="AsFoR0F7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ZQfU5vN9";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="dHVvyaXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3B42070D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rDdn8IlTTQnH8kZnUlgQb4wd6Bb1lkTgiJXGAG8XPj0=; b=dE5wLvCtWW7+8WH0vsMuefwNPi
	bNl3MEXHsqa/9FC7MyuI0QFyTq4zBq8Sn3GRxEyzxpaUftI9EPNDBvLW3gkdkBSjYKPwg3pfjKd0l
	pUKkPQN+VFKTJIBdZx8OYYHBD28/4oqbjw89vMi2/HIUolbiJ8yItNJ89DpxqFOlHpKQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hv6Kf-0005gb-A3; Tue, 06 Aug 2019 20:45:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <paulcrowley@google.com>) id 1hv6Ke-0005gM-3G
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Aug 2019 20:45:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qNvWstZCi3NXF5KJDOazsGSKWj42nw3rueoSXYGmGRc=; b=AsFoR0F7kR4GNmdycgluGDthfX
 w9hjejyz9fCqsdXSWoyv1mmu8jtDO5J8p4ASm4ZeeljCB13LtpuC+29quMvZdV863FceS8xyvsqES
 AqE0vV87PEc7Ex7xSyv857b8vwfor/26cYvtOj21nB+uVPa8PKo8yfs1DESOge7tlNAY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qNvWstZCi3NXF5KJDOazsGSKWj42nw3rueoSXYGmGRc=; b=ZQfU5vN9UUKHg8f/4UGgiyT2AF
 qj4ktJS3pjXMo39j6AtbmO6NttpxsgIyf4eynLJ0UIn/a02Uf61RIKtJSVPw132YzMNYFy6zg0nzz
 jjUPNILRO8CuTv0K/hWFuMvzrNTrlzO2J22BDwGCE8eG58acEuSHislNfqal992ZoJWw=;
Received: from mail-lf1-f67.google.com ([209.85.167.67])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hv6KZ-00D3pS-9J
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Aug 2019 20:45:20 +0000
Received: by mail-lf1-f67.google.com with SMTP id c19so62288205lfm.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 06 Aug 2019 13:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qNvWstZCi3NXF5KJDOazsGSKWj42nw3rueoSXYGmGRc=;
 b=dHVvyaXFUfwdTrXm8Qxe3g47TjDPWLCdOevoaBSnsuB2cWvNXEXQshBBZ2xZ66S7gF
 dDcbZzQwewKYPA4UdVMJKe+OULJcTBNQRzBEpqMJtuldr2635kPtBlgaOJqp7jvup6Ax
 2vW3nYb6r+xDz87ptI4JAiQyQuYpbmMXpvlUN04K30/rtTwPeJM0ZXVBbg5JrFVgVC6X
 TBupMMeehgE7wdlI130er0HeQc0ZJzdmc/c0HBvb/zb3EkUecBEQJthkHIywW1i3UI3k
 hoUKHmZFqSoR2uZzN5Z42y/WAneWxoHJkgWOGaDPO+v7fcApJ9Sd6+EPurKzfbO0Qzx7
 FJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qNvWstZCi3NXF5KJDOazsGSKWj42nw3rueoSXYGmGRc=;
 b=CVD9QQCqrwAjya3+kBlz6PVWvBf7HvGuKkvQ9OFt7HDDThcVuG8DmaY6vat63x6FZd
 fycWP0VFNTXDpz51QOPnRlhYjJYaCQc2li8XggehMPGnPY7vIQW4SktJD2f+hRB616pV
 faPLYBa7hXwa9libhjExbLUehvUrxvtHyun58P9a5WYE0VIr9C9EGqdUDC4EKEKNTEm1
 eg4SiZ3QdUGtvqqTZAFwta3hSZGoFBMkbRJWMpmaA8C+2i3qiUv8aBZGWLLTLOrAE67S
 17006uOqADBCRPGxGMXrXZcanBnxDMyfAT+UzXf6bKbQTaI2QIsZxlCDShSrT++RKwNm
 PpYQ==
X-Gm-Message-State: APjAAAX3mIgIRmbiwiADGTqPiqqOeZlXhmr7fpemO94tNgZCaX5EK+JW
 Dd8KTZWYMaYWwrecWRXodqfGGVHTHT37ktKh3/PlMhwo
X-Google-Smtp-Source: APXvYqytA61jT3xOdp0Ac43cHqnLjnFVkdCXmd0Vh+wU5xDCKIN1tOrExheH0FZXClBUGoxDy7me4b7UmNyIp24tkW4=
X-Received: by 2002:ac2:54bc:: with SMTP id w28mr3504887lfk.17.1565124308213; 
 Tue, 06 Aug 2019 13:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190805162521.90882-1-ebiggers@kernel.org>
 <20190805162521.90882-14-ebiggers@kernel.org>
In-Reply-To: <20190805162521.90882-14-ebiggers@kernel.org>
Date: Tue, 6 Aug 2019 13:44:56 -0700
Message-ID: <CA+_SqcAWniLLTk4eqWX81ypgMqnh2_9N=0JDKs3JopeV6XX_HA@mail.gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1hv6KZ-00D3pS-9J
Subject: Re: [f2fs-dev] [PATCH v8 13/20] fscrypt: v2 encryption policy
 support
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
From: Paul Crowley via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Paul Crowley <paulcrowley@google.com>
Cc: Satya Tangirala <satyat@google.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, 5 Aug 2019 at 09:28, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Add a new fscrypt policy version, "v2".  It has the following changes
> from the original policy version, which we call "v1" (*):
>
> - Master keys (the user-provided encryption keys) are only ever used as
>   input to HKDF-SHA512.  This is more flexible and less error-prone, and
>   it avoids the quirks and limitations of the AES-128-ECB based KDF.
>   Three classes of cryptographically isolated subkeys are defined:
>
>     - Per-file keys, like used in v1 policies except for the new KDF.
>
>     - Per-mode keys.  These implement the semantics of the DIRECT_KEY
>       flag, which for v1 policies made the master key be used directly.
>       These are also planned to be used for inline encryption when
>       support for it is added.
>
>     - Key identifiers (see below).
>
> - Each master key is identified by a 16-byte master_key_identifier,
>   which is derived from the key itself using HKDF-SHA512.  This prevents
>   users from associating the wrong key with an encrypted file or
>   directory.  This was easily possible with v1 policies, which
>   identified the key by an arbitrary 8-byte master_key_descriptor.
>
> - The key must be provided in the filesystem-level keyring, not in a
>   process-subscribed keyring.
>
> The following UAPI additions are made:
>
> - The existing ioctl FS_IOC_SET_ENCRYPTION_POLICY can now be passed a
>   fscrypt_policy_v2 to set a v2 encryption policy.  It's disambiguated
>   from fscrypt_policy/fscrypt_policy_v1 by the version code prefix.
>
> - A new ioctl FS_IOC_GET_ENCRYPTION_POLICY_EX is added.  It allows
>   getting the v1 or v2 encryption policy of an encrypted file or
>   directory.  The existing FS_IOC_GET_ENCRYPTION_POLICY ioctl could not
>   be used because it did not have a way for userspace to indicate which
>   policy structure is expected.  The new ioctl includes a size field, so
>   it is extensible to future fscrypt policy versions.
>
> - The ioctls FS_IOC_ADD_ENCRYPTION_KEY, FS_IOC_REMOVE_ENCRYPTION_KEY,
>   and FS_IOC_GET_ENCRYPTION_KEY_STATUS now support managing keys for v2
>   encryption policies.  Such keys are kept logically separate from keys
>   for v1 encryption policies, and are identified by 'identifier' rather
>   than by 'descriptor'.  The 'identifier' need not be provided when
>   adding a key, since the kernel will calculate it anyway.
>
> This patch temporarily keeps adding/removing v2 policy keys behind the
> same permission check done for adding/removing v1 policy keys:
> capable(CAP_SYS_ADMIN).  However, the next patch will carefully take
> advantage of the cryptographically secure master_key_identifier to allow
> non-root users to add/remove v2 policy keys, thus providing a full
> replacement for v1 policies.
>
> (*) Actually, in the API fscrypt_policy::version is 0 while on-disk
>     fscrypt_context::format is 1.  But I believe it makes the most sense
>     to advance both to '2' to have them be in sync, and to consider the
>     numbering to start at 1 except for the API quirk.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good, feel free to add:

Reviewed-by: Paul Crowley <paulcrowley@google.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
