Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F262BEDEC01
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Mar 2026 03:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PkOesxzGtHoRAVb0ERV0LWe0EQ+9ulpTH9y42O7E+GU=; b=QWxHslN0GBveXF8LYfP5RqksCH
	opIqNWj3jfEVCyS3aRkZKNz+ALYXc7KFrjTx8ZPwImA61ZxotlkKwWEnsa9wywXL3dQpiHAYrAvPq
	pAPTSa0wO114xqDxB9ujkWIgmqQ2Ovmi8/XJjPSmnJIkqcNNvvW5yqIoSiPcoBhEqzyE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxd1N-0001wG-JZ;
	Wed, 04 Mar 2026 03:35:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <axboe@kernel.dk>) id 1vxd14-0001vo-A4
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 03:35:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NrE0zI+7ilR1NedBJHHio8t27882PDymrHrpls6UPoo=; b=Sm5bk4E8jTCcbFw5Ah4qlTopeX
 QFHk97zUWIq6yLr4R0QtcfgyNDpr28mpjeKxEW5K2KFGyHLMxmgZaVxmOPHYhgTIwyEgQILsFyOHG
 cLl37xjHjopCf0Zl0BsMwwocwB1vR3Ca2rj6e9IRxOArXxIjubXubLzjxZ5Yl1ZmqTPs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NrE0zI+7ilR1NedBJHHio8t27882PDymrHrpls6UPoo=; b=QFCwNqAw+b3PtD4pDVrYQWD2D0
 wcnKOuAGe9bY8JVLwm5aN7NpUarVukfwAmZYREwvkS33oH3zZmX0BmNVb2x41KYshZy/HV2goUIbg
 w9lmPSXH45IiszPHKbshS1eEY1s3KYOf5d4DPXWJ1ZcNeoL54ajY/v2Mosp56IkSf6g4=;
Received: from mail-ot1-f54.google.com ([209.85.210.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vxd13-0005hI-Oh for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 03:35:18 +0000
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7d4be7c4ebeso3198659a34.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 03 Mar 2026 19:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772595307; x=1773200107;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NrE0zI+7ilR1NedBJHHio8t27882PDymrHrpls6UPoo=;
 b=iU7v0aVbIHmHuzGdUHH8JeF+JtmKG2biV8Wi3kqAH0PY/JWTNDHozxX/iFm6KZ3e0E
 pXRfHy0m72iFpmYZxxgtP6L5lokNWkzakqfaNjX2KkHkLJFbDuVW2x1vQcJe1Dl1LJE7
 2ZbbJyTtKphqATMoSru5joefEWAiJBFWFzCKnXSPSNz+ZDsVCxLwpGUcw8iPYc48/UKD
 oZPEhD/oL0XjHuVbuhGO8RT23LnoKDE2mz+3MkxBtw4FHSZFfuw7ViQ8Fb/RgEeU+9rP
 XMZOa27nf4M9gnWh0TrCbImHlr6yxx9RAdIS0orndmbjODcg2/zR8PPnieEgqOx19w9j
 hPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772595307; x=1773200107;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NrE0zI+7ilR1NedBJHHio8t27882PDymrHrpls6UPoo=;
 b=GRkOYt/4ubfwrz52mxhcr9asis4atUz4LHQ/rGBuzl/9ScFZnqBGcYeayEF5XNdDg0
 qKz2WEkdRkT/+kkEtQU0QPVk/Vw4/FJHNGD93eutlp0Vx3bZd63pLiYUO2sJmjJ0O9oY
 vTGU1unJIQQbRd5qN/PNfBpo8JoIn87hKTBjGhZ9qiFKzD/8NJbZBoThk67WXZQFfQfw
 AOOC0qFe0GePUxo2dcz2eTDyE7ybHiXGtKu1QOG+lokMFGKXRKQZ8QNwUM0vp/Kbc/+F
 FWS9e5NinLkMxSRjbT+lHcuF+6waljTSQvAcjMVybBImUfXoKRCCEZIc4qyzeIOuvVlB
 Jkbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+A2fi6UevspnnjOUIB2dIJ56N1IGqx0Y+aY+Uha8gNwcgdDehgFzsKwJ7z8bpaNvD1oWKe0zvKnfxDZuyuTrD@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyfFQOxoLL6SXp81XAAjkS1va+qJPsvErV77TIOGTNNoStfiPgF
 jVDTEGU+U+rK9EYj+wkM+x2wb6JmMFXwqt67RViDbncXcGb6cnPbwoAEJ+wn4WbnRJA=
X-Gm-Gg: ATEYQzyHu389jOfjn5utPm8g8xfk+OPA8tj/7rKXUlffYzZOyn+2P2Ef+rv0mY7Z+7s
 sIOzRlpaF8S8+Rv+5xzvrZCNH/D3rzAbZAy1XAzVk0qaiMekAvB3piRCjYZ2a8iJO52aVWGQ1U+
 h3PwGNchVx6aHGrnQj87wrEK0+x/WFhV67mwZUmYIVDpbkGRu39i95i2Hrxz6+0qwCH8HCCvN1n
 lHxNrZHJGPfMtZ2rTXiyHPMy5DJAC94uA0bvW4plOfD+Lx/8YARTu3DDbchU4A1kq0Gy4isUGER
 Q7TbGOVR3PkuDzztA1GxfHlkhpfBJKxs1ukXteTaY0rcOllXEilA1uojOlcNzI++q8XLNDfq8Hw
 swoQzdctACcpmJRA+qwo+AS94DYXjvTwAZuwi5O6tjsVLRFFqK9kgWtaSwfuh9BNBG2Q1nv382q
 mqnRZUbsO0OX/64zIsy3d3uoU+E6oWlzP9w5ap3KCCwYs7OcqMxeXE3ReKPFtTyv2dvmLmxgLHu
 ctyOEAnmg==
X-Received: by 2002:a05:6830:6185:b0:7c7:6977:17cb with SMTP id
 46e09a7af769-7d6d139f788mr450044a34.21.1772595307034; 
 Tue, 03 Mar 2026 19:35:07 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d586653f6asm15202012a34.19.2026.03.03.19.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 19:35:06 -0800 (PST)
Message-ID: <e96e851a-9050-4d8c-b1e5-bc3b5d91a84c@kernel.dk>
Date: Tue, 3 Mar 2026 20:35:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yury Norov <ynorov@nvidia.com>, Sean Christopherson <seanjc@google.com>
References: <20260304012717.201797-1-ynorov@nvidia.com>
 <20260303182845.250bb2de@kernel.org>
 <f8d86743-6231-414d-a5e8-65e867123fea@kernel.dk>
 <aaedwFwXh9QXS3Ju@google.com> <aaen2pGs0UeiJqz1@yury>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aaen2pGs0UeiJqz1@yury>
X-Headers-End: 1vxd13-0005hI-Oh
Subject: Re: [f2fs-dev] [PATCH 0/8] mm: globalize rest_of_page() macro
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Zheng Gu <cengku@gmail.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org,
 Jaroslav Kysela <perex@perex.cz>, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org, Eric Dumazet <edumazet@google.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, linux-nfs@vger.kernel.org,
 Dongsheng Yang <dongsheng.yang@linux.dev>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, David Airlie <airlied@gmail.com>,
 linux-riscv@lists.infradead.org, Simona Vetter <simona@ffwll.ch>,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Yury Norov <yury.norov@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Alexandra Winter <wintera@linux.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-ext4@vger.kernel.org,
 x86@kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>,
 linux-spi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Aswin Karuvally <aswin@linux.ibm.com>, intel-gfx@lists.freedesktop.org,
 Jakub Kicinski <kuba@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Carlos Maiolino <cem@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>,
 Thomas Gleixner <tglx@kernel.org>, dm-devel@lists.linux.dev,
 Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Will Deacon <will@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-crypto@vger.kernel.org,
 linux-block@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 virtualization@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Janosch Frank <frankja@linux.ibm.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Christian Brauner <brauner@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Theodore Ts'o <tytso@mit.edu>, v9fs@lists.linux.dev, netdev@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>, linux-sound@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Anton Yakovlev <anton.yakovlev@opensynergy.com>,
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Namhyung Kim <namhyung@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 3/3/26 8:32 PM, Yury Norov wrote:
> My motivation is that it helps to simplify constructions like this:
> 
> -               loff_t cmp_len = min(PAGE_SIZE - offset_in_page(srcoff),
> -                                    PAGE_SIZE - offset_in_page(dstoff));
> +               loff_t cmp_len = min(rest_of_page(srcoff), rest_of_page(dstoff));
> 
> Or this:
> 
> -               if (folio_test_highmem(dst_folio) &&
> -                   chunk > PAGE_SIZE - offset_in_page(dst_off))
> -                       chunk = PAGE_SIZE - offset_in_page(dst_off);
> -               if (folio_test_highmem(src_folio) &&
> -                   chunk > PAGE_SIZE - offset_in_page(src_off))
> -                       chunk = PAGE_SIZE - offset_in_page(src_off);
> +               if (folio_test_highmem(dst_folio) && chunk > rest_of_page(dst_off))
> +                       chunk = rest_of_page(dst_off);
> +               if (folio_test_highmem(src_folio) && chunk > rest_of_page(src_off))
> +                       chunk = rest_of_page(src_off);
> 
> To a point where I don't have to use my brains to decode them. I agree
> it's an easy math. It's just too bulky to my (and 9p guys too) taste.

The thing is, now I have to go lookup what on earth rest_of_page() does,
whereas PAGE_SIZE - offset_in_page(page) is immediately obvious. It's a
classic case of "oh let's add this helper to simplify things" which
really just makes it worse, because now you have to jump to the
definition of rest_of_page().

IOW, just no.

-- 
Jens Axboe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
