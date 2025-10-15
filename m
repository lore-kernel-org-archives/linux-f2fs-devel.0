Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CBDCCD193
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Oct 2025 08:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r0yAmoMgKNDv/GXRvfBGKMHqK3q4y0rdJ8yoeBQs3FA=; b=ETApVo9qdPU+ypJ1aXJJSca4Ka
	lKvDlYHmdrWldk/Tyo+FukQVZzpw7Cly94zpqZrsrjF/iRGEgaff4o6RZGcR8zMqVKYjkpNdBkffu
	MJOs4c8J/qEvRmRtWGz9rKtChXmeG2gAmQmfmsN7+BlsFIQNGDRkHaKXjt9HhNnYvv7o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v8xHx-0007tK-Nl;
	Wed, 15 Oct 2025 08:55:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kundanthebest@gmail.com>) id 1v8xHw-0007tE-JS
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Oct 2025 08:55:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fgEqnrxX4R0u2xnG7ixfV3NvX2lvrI5nPU8w2RGCEiE=; b=SvrVBLqg7mUp/kSlBVLgLVSPYX
 IaLfK+rn2i7YOXBbYFoUUJYvVte93thxHkUBoonfp9LJ6DX8Xj9/sBpLXLFcIdiaUx4w34UTqIYOV
 xzh6qJoK2fNNftTy72M1+LjZgsO5ClMs8Nwev32mGcK5eUG5JSaVyAFvj8uz8Ta8D5z8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fgEqnrxX4R0u2xnG7ixfV3NvX2lvrI5nPU8w2RGCEiE=; b=iP49kbK9R6ywLSHb0ylfm0hz9x
 wZIMjs9Nc3NIBPg41cc003Vum40B0LAxrq0VZ8fOWbeJQoHSRMpKuay9HwtykxT3DPKWZMn/9swBa
 F84sQmunRLF2KiLASAEr0K/NaI8bl8zgVWLf8Cnt0v5Q09Awk3vKcEI+rZU0wLCTsiTs=;
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1v8xHw-0002Ac-81 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Oct 2025 08:55:16 +0000
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b4c89df6145so1052702666b.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 15 Oct 2025 01:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760518510; x=1761123310; darn=lists.sourceforge.net;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fgEqnrxX4R0u2xnG7ixfV3NvX2lvrI5nPU8w2RGCEiE=;
 b=mI0iToTQ02x7iAm+sXhD7tZW1wpx8LP2ygFcTPi6l4g65OlxDAISyv6tfn4j1MpV1u
 HwSF3ZKb7+N8t9qJRX3XKOrg0tZsZhCeVupkyp/K6kF/eL/dgXhm4B5nvCqApQ30mOOY
 lEgbofK7tiWqytuaRU48dK0Bw206qtkepKEbyU0zMD0dlxyWcuY5sQ81iQYLO8YHzkjY
 JPcYdT48nf2uqICfSR672wkg3Iw1segE7FiQtGK14R9+jJs+gkAax0a6aDsvR3mhaOWL
 av0be6kwh78tIi/eI7HGJ2zgYNOAFsIZ0A/kn6HsRVD1wtOezd7EsF8K7y8R5pp9NRfA
 Mhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760518510; x=1761123310;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fgEqnrxX4R0u2xnG7ixfV3NvX2lvrI5nPU8w2RGCEiE=;
 b=Dkh2UgEIvPTTUi7sk1t5WGNI6kAOzUvp3EFU6k8C6s0jot02CsOpo9hD/bE+Xr5olM
 8rZHB3OQhKHU6LuaMlVgs2ath4HEE9UMhUUWIeqKyTKbA0O45BQ6kuvW0cv9szpsECGv
 BrhoEDsTwdd+X++t6J4xb+YlKyjK2cDY3E+ewhpA35ggASPdtA9iEu+YB4tRI8RfXtCE
 tdBSlkh3EJptrD46M0BqWPqrVldiJP0lBvqyzK77EK4G9g5WUWp6l8uYgO+V/ancjyVp
 gGNsjni5clRnHQnphVX+fVGgtxxtOltC0cN9WmRdABI07AA2CtMml/+sa4jSR7MoM0OY
 wCXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2HSvEbgs4jwVmwt/rqcbYqDVDGIvR45yjUkSewjjAV/P0WjCr1PJ5qd10K7fiDbLpGmqnHSWEl2XtoNVHsv0S@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyMbMa3nZzXVO+x1+AM5fm/30wnbyexL7KBtJPgX9SULQEq99YA
 xltkKvxwWA+tNTN+qYgJ7BcQFwgBeSUBpjJPn1gQTVA0slfHcsGZ5JwksBlt2QCGdtj8FO8EbB5
 MIHYHl+KienunNR2JCaQuu1bg/rer0z8=
X-Gm-Gg: ASbGnctael6QLhogPYBW0KthbIWYwO9OjOQE55i1S9fVatmVspmdRt+7jAKuCiGgM47
 HIyw507+6VtJRKDaf88YvAE5gkBeb4V9rkYISJMuE6SFxmp5hjpqUYSACf4xABdk3HIJq+0d6vJ
 DpVuL1EAAHehdOxXOk82TgE6jcQXpyE5grjgaP2BBe38CXIMrFonRoAhryIY1pDhUXrpdqrBJ1Y
 QMf2TKEwn7yaoyQ8gCiBsUfok3g3CtiizO90dPjY7q9dYnw
X-Google-Smtp-Source: AGHT+IFTcVXJ2k4Io0gR55B+LOiUs0D6lc9nA2FkAagSET75wVrURhguyB7dmaTVjRb2yFF3HFNEaUx2J8d6K4IUlfA=
X-Received: by 2002:a17:907:9448:b0:b40:a71b:151f with SMTP id
 a640c23a62f3a-b50ac1c4e7cmr3185549666b.30.1760518509261; Wed, 15 Oct 2025
 01:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com>
 <20251014120845.2361-1-kundan.kumar@samsung.com>
 <20251014180312.6917d7bd5681d4c8ca356691@linux-foundation.org>
In-Reply-To: <20251014180312.6917d7bd5681d4c8ca356691@linux-foundation.org>
From: Kundan Kumar <kundanthebest@gmail.com>
Date: Wed, 15 Oct 2025 14:24:57 +0530
X-Gm-Features: AS18NWBrpUjyPc8mxzcKZ88p2FW9F32bwQuz9_BbcqcNCJwm-Zl4oTpr4byxBk0
Message-ID: <CALYkqXp9Wewk=P79r+Q8HjngUOSWq71ZA6NBm5fPSj9EZHh1Ng@mail.gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
X-Headers-End: 1v8xHw-0002Ac-81
Subject: Re: [f2fs-dev] [PATCH v2 00/16] Parallelizing filesystem writeback
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
Cc: ritesh.list@gmail.com, vishak.g@samsung.com, jack@suse.cz,
 djwong@kernel.org, amir73il@gmail.com, david@fromorbit.com,
 gfs2@lists.linux.dev, linux-mm@kvack.org, clm@meta.com, hch@lst.de,
 dave@stgolabs.net, agruenba@redhat.com, miklos@szeredi.hu,
 Kundan Kumar <kundan.kumar@samsung.com>, willy@infradead.org,
 anuj20.g@samsung.com, linux-nfs@vger.kernel.org, viro@zeniv.linux.org.uk,
 jaegeuk@kernel.org, axboe@kernel.dk, brauner@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, mcgrof@kernel.org, anna@kernel.org,
 gost.dev@samsung.com, linux-fsdevel@vger.kernel.org, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

>
> Nice results.  Is testing planned for other filesystems?
>

The changes currently improve the writeback performance for XFS only.
We have introduced a callback that other filesystems can implement to
decide which writeback context an inode should be affined to.

This is because the decision to affine an inode to a particular
writeback context depends on the FS geometry. For example, in XFS
inodes belonging to the same allocation group should be affined to the
same writeback context. Arbitrarily distributing inodes across
different writeback contexts can lead to contention of FS resources,
which can degrade performance.

I conducted a sanity check on the performance of EXT4, BTRFS, and F2FS
with the current changes, and the results show no performance impact.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
