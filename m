Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A48BC38A2D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Oct 2022 19:36:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1on3FO-0007z0-EW;
	Mon, 24 Oct 2022 19:36:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1on3FM-0007yp-OD
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Oct 2022 19:36:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OhQpzoeVGEwmo14h6MNRUCVjD46EBvZeUnXF6FjYKqc=; b=UO1SAEpLeLCeTEYskhlOCzN1go
 wmQbS0xXYQ2omjesnr+JHE4Fz6J4wlIxCmOggdH1GXLjPdgStGkTyWLTUZYMzEqXXE/heqHk5S9RP
 pttn622/aNeRqh0iQ/B5S+4vk+o8m5gZyDss4jblto9mpp0K48jZ5Zqvu2vBvujF9UDA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OhQpzoeVGEwmo14h6MNRUCVjD46EBvZeUnXF6FjYKqc=; b=j1+S4fgd33YRE/wPJnbjj321wA
 KQAwqnsgknmA+JccqhrExw8zTZsH8NDV+xKEBzvsVo0g2CgSZZmjdESRmR2y2qm69XJgOos7xPBKS
 T5OxL/vMKs9n3Xr6TVszGdGEQK/9uvYegf0/JhVWeBxR4ymP3AmewC/QZbFBW53FSAM0=;
Received: from mail-yw1-f181.google.com ([209.85.128.181])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1on3FL-00G1tS-Kr for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Oct 2022 19:36:28 +0000
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-36a4b86a0abso78624047b3.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Oct 2022 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OhQpzoeVGEwmo14h6MNRUCVjD46EBvZeUnXF6FjYKqc=;
 b=LWqs5CgYoI2G7bwSrxm509BXkoJoj4h1+NAumrnw8GvlsTUUX0V7puTaejDjA+a+Se
 JZxLEhr98Isu6X1gDcr7CkjpAxT8QlsxaP3cMesu5io+uJ/hiaxizHNPmkvonW4ZrSM3
 9FJelnA+mhjpIKDB4wzNLTg8Yl25Bz2AgN5mLB8NjrqH3r4M0xDO+raYYo0KOsCBYSik
 v9TQ8VEWW7hntj+Pu46z7CX8Gt3ApfbvP2i70kguAt+Ou14BtRsnM5RXks+7xrvrVctd
 Sdn2UK8OpZrhDItYKOmqTRxqsyQ+eocL2ZMu5oL7CUQlM4vOpL4lrxfytXhVZRRPAgrU
 MCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OhQpzoeVGEwmo14h6MNRUCVjD46EBvZeUnXF6FjYKqc=;
 b=akVaykeUdZzQBnS6Bxx3yQvK/xSLDDtMVstJbssfyoP6vhQd61BUnBO2f5QUKcd1Xx
 tTHOQNdOWj7V9sipsmCRKbtFvPaS+u0gXQspVZ2PpOzuaACZlPTh7SjSK72Y3CI7V/sr
 b46d/WUeUUwc8bAqeUGvKyG2Aq5JsZuwWUH4tVf0WULHwrs6XMyV1M1stS5VhiDWt0An
 61imSOlv+poQx8mi5wDFZnHsorIVENpSELUWAWFwvbjLVYYKz7Kbona1089+ve2p4GaG
 1Csp7Zr3uK5VCdga7HB6gcZQN4lQ5zH8w7xFYQCgcH+QsJDyX0z86ZTv9Ctwf2n92bWM
 8fPg==
X-Gm-Message-State: ACrzQf29drGseyVnuHh8Ct9sKsTR/CrRGGF31tAMTEmt0/ePvq+YC0Go
 AuZaQ0slR3+EcL64SuvCmlDRAQruYzGBxKz+Ugw=
X-Google-Smtp-Source: AMsMyM7XF706RQysgvnkUL+jiUes9sa+q4VpOE9nihO77SiOflxp7+5NwMrZHWz4l1+JriXP7Udvq8USTVKNN8z/wRE=
X-Received: by 2002:a81:71c6:0:b0:36a:5682:2c44 with SMTP id
 m189-20020a8171c6000000b0036a56822c44mr14328584ywc.308.1666640181761; Mon, 24
 Oct 2022 12:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221017202451.4951-1-vishal.moola@gmail.com>
 <20221017202451.4951-2-vishal.moola@gmail.com>
In-Reply-To: <20221017202451.4951-2-vishal.moola@gmail.com>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Mon, 24 Oct 2022 12:36:10 -0700
Message-ID: <CAOzc2py2E_zFukvSv-BcDm+mJis44Zp0fksd49mudMkU52HpZA@mail.gmail.com>
To: linux-fsdevel@vger.kernel.org
X-Headers-End: 1on3FL-00G1tS-Kr
Subject: Re: [f2fs-dev] [PATCH v3 01/23] pagemap: Add filemap_grab_folio()
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
Cc: linux-cifs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Oct 17, 2022 at 1:24 PM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> Add function filemap_grab_folio() to grab a folio from the page cache.
> This function is meant to serve as a folio replacement for
> grab_cache_page, and is used to facilitate the removal of
> find_get_pages_range_tag().
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  include/linux/pagemap.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index bbccb4044222..74d87e37a142 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -547,6 +547,26 @@ static inline struct folio *filemap_lock_folio(struct address_space *mapping,
>         return __filemap_get_folio(mapping, index, FGP_LOCK, 0);
>  }
>
> +/**
> + * filemap_grab_folio - grab a folio from the page cache
> + * @mapping: The address space to search
> + * @index: The page index
> + *
> + * Looks up the page cache entry at @mapping & @index. If no folio is found,
> + * a new folio is created. The folio is locked, marked as accessed, and
> + * returned.
> + *
> + * Return: A found or created folio. NULL if no folio is found and failed to
> + * create a folio.
> + */
> +static inline struct folio *filemap_grab_folio(struct address_space *mapping,
> +                                       pgoff_t index)
> +{
> +       return __filemap_get_folio(mapping, index,
> +                       FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
> +                       mapping_gfp_mask(mapping));
> +}
> +
>  /**
>   * find_get_page - find and get a page reference
>   * @mapping: the address_space to search
> --
> 2.36.1
>

Following up on the filemap-related patches (01/23, 02/23, 03/23, 04/23),
does anyone have time to review them this week?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
