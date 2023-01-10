Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF076C54EBC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Jan 2023 12:28:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pFDjT-0001zx-Ly;
	Tue, 10 Jan 2023 12:27:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <glider@google.com>) id 1pFDjH-0001zi-BY
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Jan 2023 12:27:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6KndhW8ZthnZXH5GZJH/lEnO//E0T9z85lpDRJv/Coo=; b=DhtKgPdJvEr1ZXALTJjQVIk4M+
 LUnqCW/goOUJmwXRpCpVFJM0KaWcUrQOu4kEKqjU+dSjhUW6bnyP11BmQnVvcpEnmL12KyBbZx01U
 S2kHcXUzdr0GkC5Rp8g/uV0tMUKXoGf+YIkkHyUHS7pkD2a7z2NtmRoTF3RStZUylT50=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6KndhW8ZthnZXH5GZJH/lEnO//E0T9z85lpDRJv/Coo=; b=SZ4vBW62wlp04Mim3O4uiKQIlK
 t02bZiTL1VlsPxd67lePU1GjXFcA3Z34GloL9nGzTWY9lUj9Op+Ybu7Rh2xFv6wKUOuaXVGQDNoQs
 BnDPPBfvKIFDigT1b5AX1lrJ/UVuAM13IqKCV4PhYC5FCabHyaK5BdOl6cPcBD48Psew=;
Received: from mail-yb1-f171.google.com ([209.85.219.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pFDjG-00Crcd-Aa for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Jan 2023 12:27:47 +0000
Received: by mail-yb1-f171.google.com with SMTP id 16so11649747ybc.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 10 Jan 2023 04:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6KndhW8ZthnZXH5GZJH/lEnO//E0T9z85lpDRJv/Coo=;
 b=fLHC6l/L0Ijx5D2CAJDRuaGTh0+lAqH7wRXf4FXEos/1kCMAzIGNE/a19cTVHPstyj
 JwaTeSROjJgdKlGX2jhdbFh9OyFkzqux7VGs0+lrSZRTtt+esc/w3XrW1M+qkRBOzrNd
 2+HGDXTDKGfbMGyWkagwgv+cThJ+qjOtFr9rhUtHn7QO3oehJwbga1TlShhaSinIURvU
 54pzeCiKxGHjU4wHJ1X9db9bwm7ajet6de0BfVL4IT7QfNxXO2bScK09DianQE/OI7tU
 jt+NXznD2zJ0+5lt87pz53ZPLKBDIvsa2HqYHFm4kDDKjA7Qdg+pqmsS6UU0Sqqna8hx
 /OvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6KndhW8ZthnZXH5GZJH/lEnO//E0T9z85lpDRJv/Coo=;
 b=O4P0SqqRhXqfHk/7Nm+mbtaXhINUT/4aAJ0d4vF443fgRcIPc4MavNzXq3PNxJl3I3
 FomRMIc6whGxLZWL32Q0uxi+kcw+cSPl4aimFzUd21FjGWIfNVWYDvQVmnWeOB6OgeOX
 SHAEhsLUGjzwYBNy3GbrNM3t5UmTFEzFNR6uXHHFl0Bammf77/toui5f3c2xRL0gN4NR
 Qc4rYKitqaKtXxb5uNQd8WOwcMNBAVUm6emcaU20ZxuFzmk0c5Uw58mgTnt21rZgd74v
 VSVTTYoqzQWW28lPEw/gQTu7DC4jkGhheMpOR9xmaK74XTCNEG34ghHRWJExVb39r0Bo
 XCbQ==
X-Gm-Message-State: AFqh2krZt9jLihvQcu+gLv+o2IwGSzSOmtzEXy7xL6n13GaA2eg5l9yI
 tJ6tGU0gLUtoaBa48m+ww3QqkFlhQAJvjMKwMXdIJA==
X-Google-Smtp-Source: AMrXdXuKs2wl/bseH+adSS22ymofeLisqiz/F7ZTp9k5notKnLu5IuY4AXMn8tcdHRycayafMh+GPeKHWlUwXyTIcIU=
X-Received: by 2002:a25:bbc1:0:b0:6fd:ef90:2ae5 with SMTP id
 c1-20020a25bbc1000000b006fdef902ae5mr5331591ybk.376.1673353659656; Tue, 10
 Jan 2023 04:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20221121112134.407362-1-glider@google.com>
 <20221121112134.407362-2-glider@google.com>
 <20221122145615.GE5824@twin.jikos.cz>
In-Reply-To: <20221122145615.GE5824@twin.jikos.cz>
Date: Tue, 10 Jan 2023 13:27:03 +0100
Message-ID: <CAG_fn=Waivo=jEEqp7uMjKXdAvqP3XPtnAQeiRfu6ptwPmkyjw@mail.gmail.com>
To: dsterba@suse.cz
X-Headers-End: 1pFDjG-00Crcd-Aa
Subject: Re: [f2fs-dev] [PATCH 2/5] fs: affs: initialize fsdata in
 affs_truncate()
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
From: Alexander Potapenko via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Alexander Potapenko <glider@google.com>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 akpm@linux-foundation.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Nov 22, 2022 at 3:56 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Nov 21, 2022 at 12:21:31PM +0100, Alexander Potapenko wrote:
> > When aops->write_begin() does not initialize fsdata, KMSAN may report
> > an error passing the latter to aops->write_end().
> >
> > Fix this by unconditionally initializing fsdata.
> >
> > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Alexander Potapenko <glider@google.com>
>
> With the fixed Fixes: reference,
>
> Acked-by: David Sterba <dsterba@suse.com>

Hi David,

I've noticed that the ext4 counterpart of this patch is in the
upstream tree already, whereas the affs, f2fs, hfs and hfsplus
versions are not.
Are they picked via a different tree?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
