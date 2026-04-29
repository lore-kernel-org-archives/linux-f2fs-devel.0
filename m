Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95807FF887E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BMGaONif9ukVnFeB8Yu1Oqlcq18F2aSa4Sjax5Uxlqc=; b=lsnyerGUez7w5lIsXxTCsX68uz
	CCccoFChOEoMXC8DrRNTr1GqoFTPdPROYuFpcmY8EsuxmJs4uqMJDSjb0IuIoXcjLPvJPrKq+EMMd
	Zal6XHNmROE3o/bxNYKjG4TzRUjCQo8rtQmqqPeAxD1gSyX2TYWN3i5MMwVWtjTWGsOo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wIDCn-0005Tp-QE;
	Wed, 29 Apr 2026 22:16:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dxdt@dev.snart.me>) id 1wIDCn-0005Tj-2V
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Apr 2026 22:16:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q+hGRNt4Qu8Kg28XQ4VG6Co93Cs9xCHkhw8gVF9vba8=; b=U8ryT6rc5OzX3t2CD/b9UghJVW
 nBqpCq1CeNqlUQFChocbsSU/fA1P4WU3U3EFD89ZW7R0kiwl+mYw6qa1f3Ovu4KQXTSxw3Mrg4hE1
 HCC6qU+FvLtRpG9elFt2vI5GSF3KGC8MS6sdVt8lpMBRZgCzLvESJ3SMZwiVDQOVHuTA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q+hGRNt4Qu8Kg28XQ4VG6Co93Cs9xCHkhw8gVF9vba8=; b=K9C38zHsL+3F1KjKqRYr17+sU5
 IpqyVKxb4VxY4iIHKgIlW3CvLfSSE+sLdxerJh2VSlkDKFBRkRmOpAjQwX4JGovQDnX24Knr9uiZu
 JCGb6UPLJmKKNnAQmof1T8jcg2i8x0rB2c8LxlaWcv842IqHFfxUcARXDcNB7awQNKgU=;
Received: from embla.dev.snart.me ([54.252.183.203])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wIDCm-0006fN-EC for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Apr 2026 22:16:29 +0000
Received: from embla.dev.snart.me (localhost [IPv6:::1])
 by embla.dev.snart.me (Postfix) with ESMTP id A21F41D459;
 Wed, 29 Apr 2026 22:00:08 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
 by embla.dev.snart.me with ESMTPSA id nLFlEmh/8mm4swUA8KYfjw
 (envelope-from <dxdt@dev.snart.me>); Wed, 29 Apr 2026 22:00:08 +0000
Message-ID: <3d3d6e22-b8a7-4f32-8046-697e45ec6c04@dev.snart.me>
Date: Thu, 30 Apr 2026 07:00:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chuck Lever <cel@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <20260429-case-sensitivity-v12-0-8057123bebe0@oracle.com>
 <20260429-case-sensitivity-v12-4-8057123bebe0@oracle.com>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <20260429-case-sensitivity-v12-4-8057123bebe0@oracle.com>
X-Headers-End: 1wIDCm-0006fN-EC
Subject: Re: [f2fs-dev] [PATCH v12 04/15] exfat: Implement fileattr_get for
 case sensitivity
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
From: David Timber via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: David Timber <dxdt@dev.snart.me>
Cc: pc@manguebit.org, yuezhang.mo@sony.com, cem@kernel.org,
 Roland Mainz <roland.mainz@nrubsig.org>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 linux-ext4@vger.kernel.org, linkinjeon@kernel.org, sprasad@microsoft.com,
 frank.li@vivo.com, ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de,
 jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org,
 tytso@mit.edu, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 hansg@kernel.org, anna@kernel.org, linux-fsdevel@vger.kernel.org,
 sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/30/26 03:07, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Report exFAT's case sensitivity behavior via the FS_XFLAG_CASEFOLD
> flag. exFAT is always case-insensitive (using an upcase table for
> comparison) and always preserves case at rest.
Not necessarily "always".

Link: https://github.com/exfatprogs/exfatprogs/issues/313

The specs(SD spec part 2 and MS spec) leave it up to the formatter
implementation on how the volume should behave. The observed behaviour
is that it is quite flexible: you can pretty much use any artitrary
up-case table to make an exFAT volume behave completely different and
major implementations including Linux and Windows kernel honour the
table no matter what. So exFAT is not so "binary"(folding vs. not
folding) when it comes to case folding behaviour.

NTFS also has a similar up-case table feature. Although it's usually
unused, if an up-case table exists in the volume, the implementation
probably has to honour it(although this is not written down in any spec,
this should be the expectation).

At the end of the day, it wouldn't matter much because no sane formatter
would produce a volume with some weird version up-case table. But if
that attribute plays a important role in some system that has some level
of impact, I suggest considering another attribute, say "unknown" or "it
depends".

Davo


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
