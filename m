Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925CFE67808
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  2 Nov 2024 16:46:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t7HH6-0007Tw-En;
	Sat, 02 Nov 2024 16:46:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ardb@kernel.org>) id 1t7HH5-0007Tj-0L
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 Nov 2024 16:46:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E38ED0bvZ8ViDN76LuuGorJVL00ITAOwya5y2WsL3AA=; b=e5MGUy7MfsUcpydj3NMSkj8YEv
 xb4W4hYqpK5RkrfOp2mx/8FeYCJKFWifUC9xXAIvEmdD4gog5tDlf7+fcLHUz4no3x9dyIS3jgFDz
 kADHq08lM/zbUwAKAnNpsAjUHChu20ZgC+wGGkjFzedY7Kf5Ytd8rMRIuFNwmP1ffAeo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=E38ED0bvZ8ViDN76LuuGorJVL00ITAOwya5y2WsL3AA=; b=CgfhPIWMzyBBtBW29XbQeDpVtu
 IsNCssPTiHRuvck7/TdzK7cufoeVpfo+edAxu2GATBkP6URBVE4/6Zvb1KKVXxekLi1Pb/LIoTKaC
 sfCfzmUCGxiSowEX8wbpyvSowPL+Fis6Z+780WVgJT4F6FDmmtZmS8Nt43/Mp7RPYoKQ=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t7HH4-0006ZC-8Z for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 Nov 2024 16:46:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 330C6A401CF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  2 Nov 2024 16:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5CBC4CED2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  2 Nov 2024 16:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730566008;
 bh=GxoXhXGyHNH8GVqUExL8Ti1VvRWiwrpIEQI7tN7LYew=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=NJ+1XHVrktQ9WGmo2EqP6wMVn/OEt/Sv2350oNUT4r8GsAp9SYm0VRx1/D+bpxg8g
 AhMeZGuz9tEsHn97hHwlwmvLVZz1BdRK3HPFE5YqLcs8A8XoDyXbcjgPGJYTBYv2lw
 e7zJmHAonSkqpKaKaw6UnNUCHZimTZLKO1FLqORq1mUqGyfy2E7ES/38e2axn3jHVc
 vyfrkc6wWAWUTuzFcDsIW2fxGUusCopNRtdPosLD46rmwBPJUZoGz8kFjaYjXuuFth
 EueP60OBXtYFWJvxL+0V8IT2yf0FfbKIXjL0+19V3Zm0XEOHjVKdBVOhl1og12Usc6
 DBoCweRx5bdQg==
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-2fb470a8b27so35724401fa.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 02 Nov 2024 09:46:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVguZXVjK0M7EQNTazzp5CTAbyNKyzP6cb+k/T/rvr7zBKZ6X8025FIw2m7NX/s0c4+gGRLEfsb2jDyT6WlUvgi@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxqlXfMCss0hUwSxa8lHwF77iKtSACLBuh4k0H1F5C+5a6pk4Hn
 UF56e81gm+UOGEZSsJGG5N6C0i+kihOmZzq97DAF7j0QTsQLN1iDUmRL2qgGqIokB/iU1fCe/J4
 gS1ozBN5QDU9gclvHE6Af59LRDbU=
X-Google-Smtp-Source: AGHT+IF1qWuAPM7OXxHa9PDtIx4xdAi/SPdwq1d4i906hC2y1gUwoZbqVs2/tV8+cHeYBRRGdC2ase7pF6ri9+FpJxc=
X-Received: by 2002:a2e:bd87:0:b0:2f9:e1ce:1276 with SMTP id
 38308e7fff4ca-2fedb414a6amr24137441fa.11.1730566006632; Sat, 02 Nov 2024
 09:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241026040958.GA34351@sol.localdomain>
 <ZyX0uGHg4Cmsk2oz@gondor.apana.org.au>
 <CAMj1kXFfPtO0vd1KqTa+QNSkRWNR7SUJ_A_zX6-Hz5HVLtLYtw@mail.gmail.com>
 <ZyX8yEqnjXjJ5itO@gondor.apana.org.au>
 <CAMj1kXHje-BwJVffAxN9G96Gy4Gom3Ca7dJ-_K7sgcrz7_k7Kw@mail.gmail.com>
 <CAMj1kXG8Nqw_f8OsFTq_UKRbca6w58g4uyRAZXCoCr=OwC2sWA@mail.gmail.com>
 <ZyYIO6RpjTFteaxH@gondor.apana.org.au>
 <20241102163605.GA28213@sol.localdomain>
In-Reply-To: <20241102163605.GA28213@sol.localdomain>
Date: Sat, 2 Nov 2024 17:46:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEQHiqkO7j1W55UHGg-LNF2CNiPnpHcKfCdKnxFQSJ14g@mail.gmail.com>
Message-ID: <CAMj1kXEQHiqkO7j1W55UHGg-LNF2CNiPnpHcKfCdKnxFQSJ14g@mail.gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1t7HH4-0006ZC-8Z
Subject: Re: [f2fs-dev] [PATCH v2 04/18] crypto: crc32 - don't unnecessarily
 register arch algorithms
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
From: Ard Biesheuvel via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-scsi@vger.kernel.org,
 linux-mips@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-crypto@vger.kernel.org,
 loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-ext4@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, 2 Nov 2024 at 17:36, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Sat, Nov 02, 2024 at 07:08:43PM +0800, Herbert Xu wrote:
> > On Sat, Nov 02, 2024 at 12:05:01PM +0100, Ard Biesheuvel wrote:
> > >
> > > The only issue resulting from *not* taking this patch is that btrfs
> > > may misidentify the CRC32 implementation as being 'slow' and take an
> > > alternative code path, which does not necessarily result in worse
> > > performance.
> >
> > If we were removing crc32* (or at least crc32*-arch) from the Crypto
> > API then these patches would be redundant.  But if we're keeping them
> > because btrfs uses them then we should definitely make crc32*-arch
> > do the right thing.  IOW they should not be registered if they're
> > the same as crc32*-generic.
> >
> > Thanks,
>
> I would like to eventually remove crc32 and crc32c from the crypto API, but it
> will take some time to get all the users converted.  If there are AF_ALG users
> it could even be impossible, though the usual culprit, iwd, doesn't appear to
> use any CRCs, so hopefully we are fine there.
>
> I will plan to keep this patch, but change it to use a crc32_optimizations()
> function instead which was Ard's first suggestion.
>
> I don't think Ard's static_call suggestion would work as-is, since considering
> the following:
>
>     static inline u32 __pure crc32_le(u32 crc, const u8 *p, size_t len)
>     {
>             if (IS_ENABLED(CONFIG_CRC32_ARCH))
>                     return static_call(crc32_le_arch)(crc, p, len);
>             return crc32_le_base(crc, p, len);
>     }
>
> ... the 'static_call(crc32_le_arch)(crc, p, len)' will be inlined into every
> user, which could be a loadable module which gets loaded after crc32-${arch}.ko.
> And AFAIK, static calls in that module won't be updated in that case.
>

Any call to static_call_update() will update all existing users, so
this should work as expected.

(Only x86 has a non-trivial implementation that patches callers inline
- otherwise, it is either an indirect call involving a global function
pointer variable, or a single trampoline that gets patched to point
somewhere else)

...
>
> So I plan to go with the crc32_optimizations() solution in v3.
>

That is also fine with me.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
