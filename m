Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EE8C53219
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Jul 2026 05:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hf6V3o/wXnEBi5ZtSazwXHgoNdnN1PHGgZeE4seAoGQ=; b=NoPHa/0gH9Xngl9Orokm7PfoaL
	ggUKUj3QJzOQLmQtBjuQ7hAuYhLxH29Qy2RoN7qxDCZlqDU9TumamPX5TlUh/xXHRsA1T2nBJ3vGw
	zkuZDbQrh74XMubTLBwwhT1CY9VLzApqO4XopT7yZkoK38PlUv2av9WulS7TCDXcNKMo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1woacZ-0008VP-RB;
	Tue, 28 Jul 2026 05:44:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daniel.vacek@suse.com>) id 1woacY-0008VI-VK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 05:44:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YfjN6gu+ln7t5y5mDONTsNJDbtGDekxXLrfrMU8/Ds4=; b=cymkh7m2v7Ow7CFwXIFQW4w8pP
 5X53KseOe7Kb06r2s3tASc/DoUGYFmzI9Bn0ESoolmODHmmne8vpYqd93ULaynHeuMfzOnXwMwwVx
 wuJG3SIfjOPnRVEdIAy2gf5W3Y3xCbRYp16FZhgRcj0ztdGlOuU5VMcT6ZYzIV6g6M/c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YfjN6gu+ln7t5y5mDONTsNJDbtGDekxXLrfrMU8/Ds4=; b=Ru4N7eDIze0rPAwrpc2DdgimNc
 0R9ZaXNqFtWGOEAeV13u5WOQ5OHcdJxG/UlX8cd2mK90EFl8NGOp0PgOZ/f6f5OGXSAL+v+t8DefE
 AbkqJw4dDzYt2zGuC+9iy0qJHLNqyfN/Vyy42LPvYaZo4OH7K9lyds3mmijQ5kc1qvxY=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woacY-0007xR-SU for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 05:44:55 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49557167508so32614145e9.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 22:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785217488; cv=none;
 d=google.com; s=arc-20260327;
 b=P+5fpd+/Q6KpxnpmNYz5sj+fbgm6TTgVW+3r+9IGtK/MOHWoxWYwMCsM8794YfVrAS
 iNcyiahw9YHF/B3IunW9JmuY2CbSZ24YxVVLQgQJWMcEUzTiQhZmhG17q48qWnJkobA9
 tX9hF/dLnlN2HDIRp9vtQrBVgEQ1Raz0UzcSRr/qR1bxAnybd6rEa8xDBBmVr0cILyRu
 a5/kjF8aR6qshk8MglCmoxznrjbMWWOdgqOgP/YT8xamxZ0f7hPBhOJz4XsBEkwPFsem
 cFO4Y6pAb0stLawbpfDzSW9XEuIvQqO+ltT7GX4nXItQHCY05DB2DHkNc6vaKVGLwEyb
 PTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YfjN6gu+ln7t5y5mDONTsNJDbtGDekxXLrfrMU8/Ds4=;
 fh=aRdKDtvkgjzBgJA8asRxJyMkI2qp0RKLUgapiYOENIE=;
 b=Axv7vhf5W9p1PslMEiYb7yKROm+NMavnXGHo9WVxcw6M0BYoKX6X6tURfb6XFQEeWs
 r8EcE8ey5jth4hg6xgWHuYNBaiow0pNIVLDAdUtSPaMlozaW4ssGjqSUt0z3930DZi1B
 6A0Bvvv6eTN1V/IpTXbpRqCW7WmisweKejblwg8jdTwoH1iUk974Mm9p8QC5bUiQqQ9j
 m6QDqyNa6jr6uqQp2Kb9o6xDsEyhH+sNw3rcnLdh4xrAXRmacx/2yL7lh7REdR2IfwwH
 8ogLBVp9/EYguCEHkWuWE1gUq/TbK556uHHBUrYyzZ8YSL5/rfB1yNSj0thUj/Ok8KSd
 Kx7Q==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785217488; x=1785822288; darn=lists.sourceforge.net; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YfjN6gu+ln7t5y5mDONTsNJDbtGDekxXLrfrMU8/Ds4=;
 b=BPAjrFG4cxIBaOeOSzGJ80TJf+ygU8qEsiC8LKnMTU5aL6b16zqlqEghm84fee7s+j
 fAxQr8B/jio/TD5OvzWmDumwt/k7OgTrSPasWz8BxUT2zG36bdvh8MOrO3hxYFsrLsdv
 ZgMypMTDNpRFedcpg6oChodgasmBAnWlQup9Lk0M1z38uhWa1OFLjDrpuYraPwFBvPwZ
 BzDv05X/JodKd7rucJ1so5eutpBfMeyzFMzBJ5TjjXoKEE6xOpID9ImQCfTtTIhqs4is
 YS6MbGJjd1VT5Cx9f3VOH3a22QbMTHh3LMr2w1c8a20ttDWXrN5BiW4vEa0SM4S+5AaW
 oJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785217488; x=1785822288;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YfjN6gu+ln7t5y5mDONTsNJDbtGDekxXLrfrMU8/Ds4=;
 b=YmnaYcVurX1d3bFmkCfs6lZjFShMd25Ix4Dw5hoqmyhZPkB/Rr7pQhqrkO6Udn7kQq
 hwTW9Me2sc+EgN4rpE7vsL/+xarlY4rlMCV//hQDmBjd+cmUo4ZKuHp76a4pVuiSiwt3
 D+KRd3AddVBmHFDIXi4fafqfSbpH4+8zVCncW3fpR/lldpBfbJ+SVsZK5cvx+HeJH0fK
 qxKuhOO07S9TKD3HYR0PrxYVKJLp2gSOkxoo4yk9q0A2308OVWBCQqPzbf/QRzsttwrs
 i53ZsC4t0qqBoAMkx0f3wQ+WRFNp9GO/P8eaAHOHXu/z3BkycV5mYCsqcf9h4w+HzYhK
 tyWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFH/xF7rB1gDihDXQfmMxR7PmMLxHqirJqgHujSyy/12l6rsFRQwoX4ZCOz4lkXSQvl9qeG/LqCKkdDBizR8Ej@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwoZH/8XEfc60hcHruYO6IcajW5/y5H919cXywzb49QwWf1dCYY
 2fNa/0FJNXpxKQ1iXUjEB5k+2V8p0JbUnM29YuYv+vA9iWJ3tf9pKz0YJtJU8S7mYAWjsx4U1Ty
 SMfpJHdAiZF4M9Cpfd01Yox8iNOChVakJ6UuBMyi9gA==
X-Gm-Gg: AR+sD13ZyD6ssAkomEhZ9IqzDyE2fWoToHW9QiQoJlK1F7Z7mU+cwoZmQ5GImG0eHWP
 y+TNxWOvMj1O49PNDfOWDilKrE7JMbkRv8aEgtu/zZSgTpFxPMRC/2llTuNqHrnusmiznUCXNdi
 UjEE3arClUvqIcB8QK1F6AYWWqkMQQb+I1Uh+dTlycHv1toITVmNKL1VNQoP75bKSfA0KQcw+4f
 AJH1448Iog9kY1I9swzW2jA0uV2o2fKRZZgkF9C4LorZDSS9TMaCi2WWYjU0SyPvXiI2l2sSK5f
 kYFlUKX/N+nYDJgHmnNYRRFik5OwFB44pl2VoUraku1C4A85D6m3kwwyuQs=
X-Received: by 2002:a05:600c:a012:b0:496:c18c:f9a2 with SMTP id
 5b1f17b1804b1-496c6586ad0mr8148725e9.34.1785217488357; Mon, 27 Jul 2026
 22:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260724133328.1837318-1-neelx@suse.com>
 <amgfuk12imPN2XJe@infradead.org>
In-Reply-To: <amgfuk12imPN2XJe@infradead.org>
Date: Tue, 28 Jul 2026 07:44:37 +0200
X-Gm-Features: AUfX_mweqQ4DC10RBxGq9-w14Z5dbzAU5cW-2aUZfLxC0EG3IWa7sp-qvz-yJvY
Message-ID: <CAPjX3Fd1KPswrsNe=BeDpkDwi8CmL9HNKcPScMsgGN16MDyVEQ@mail.gmail.com>
To: Christoph Hellwig <hch@infradead.org>
X-Headers-End: 1woacY-0007xR-SU
Subject: Re: [f2fs-dev] [PATCH 00/12] fstests: introduce fscrypt support for
 btrfs
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
From: Daniel Vacek via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Vacek <neelx@suse.com>
Cc: djwong@kernel.org, zlang@redhat.com, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, David Sterba <dsterba@suse.com>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, 28 Jul 2026 at 05:19, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Jul 24, 2026 at 03:33:16PM +0200, Daniel Vacek wrote:
> > This is a rebase and cleanup of older patches [0] from Sweet Tea and Josef
> > fixed to work with the recent kernel and btrfs-progs changes.
>
> I'm not sure if you post this just for reference or what the intent here
> is, especially with a cover letter like this that doesn't have much
> information.
>
> Before we doing anything for the btrfs-specific fscrypt changes in
> xfstests, those changes should be accepted upstream first.
>
> Maybe some thing like splitting tests might make sense without that,
> but then it should be posted separately.

Hi Christoph. Thanks for looking into this.

Yeah, I could have been more verbose, perhaps also using an RFC tag. I
wanted to get feedback and a review from a wider audience to see if
this is a viable direction. This is currently the base for my btrfs
fscrypt development testing.
Especially for upstream fscrypt changes, when sending those patches I
was asked about tests support. I understand to keep fstests OOT as
long as the kernel part is in development. But at the same time I'd
like to make fstests complement the kernel part and ensure they are
ready and available for everyone throughout the process. Kinda to
"bundle" them all the next iteration.

Would you suggest otherwise?

--nX


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
