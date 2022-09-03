Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC72C54EE9
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Sep 2022 17:38:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oUX6A-0006BQ-TF;
	Sat, 03 Sep 2022 17:38:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <konishi.ryusuke@gmail.com>) id 1oUX69-0006BI-DU
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Sep 2022 17:38:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XIAWHihpR6QwqgJNOUnH9+J9hxcC7HnY/D9h72CaivA=; b=emKopKxthzfOjhg5OPenueWAwB
 pKfR+Fw2j2q3Qo3VUD85qdwUfqJOh1Vaf1bJlYYiEBS6O3WcdYgW8Vi9FkwV/0gQQt9KWOaajW+0U
 FK691gWnGlYBLZ02IzgLYuEjsNkYRvj4ny+4pSG0317jlxX9aF5t+EoSoxh011KDNvMI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XIAWHihpR6QwqgJNOUnH9+J9hxcC7HnY/D9h72CaivA=; b=bCnMG4QgXkDfpiktFQ4J8WC4JE
 qmZoYKmP6z/iVzWl9UaDjQG7UDgeCoMO2PyzHxishyMNbhkJvAC6MvOzHduQUGYz2GQiOVsI1r0/B
 bcopKvBCb9KwZYQ6N7NQTKXepqLE1etmUtotvrXmu38tvCFVnv/mkwAW7gnSz06eMxTY=;
Received: from mail-lj1-f182.google.com ([209.85.208.182])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oUX67-00CdUR-Ka for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Sep 2022 17:38:25 +0000
Received: by mail-lj1-f182.google.com with SMTP id b26so5206538ljk.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 03 Sep 2022 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=XIAWHihpR6QwqgJNOUnH9+J9hxcC7HnY/D9h72CaivA=;
 b=iwt/wbMtnp/q0jVwHZiE00ed484O19jfhyipFrnvrNDTORiNZ1YXFxifJnNfs+VIu9
 ZTzJdY3uSO7qeUpTw2k1eYh0iMaaR6rQ8FuxoMwtiryw0IEKTNIkNHct1rD+slZ4Tw3r
 2OJU6WtHfNa9JKbDME7ah4hIZPU0j1jGPO6PMrWVJGeSkDHa//D/ignX3illfN2ha+TJ
 H+1EyPYXY67aUIRp/z/7mkQ/sL95sVYevI1LF1OzGgAjd0Pv/Gsr8c9VZ3+AuDk1sG2J
 r1O9wMojCiVxZphiPxfZs3xs1ZBF71kfoIwvvHBoqJxzYkmzLzcX+xnqdBb0Y9xkMCKf
 tUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=XIAWHihpR6QwqgJNOUnH9+J9hxcC7HnY/D9h72CaivA=;
 b=bR+qMtwZk11L/gjH1jat1ne1xBYbUDSs/PQYMHa4MsLuzEwfb4ghHgFmgoXjmT2WdN
 TiCvmO5tYnA2jYytaUWE36PxE7yVqj709EBBfkxqE7U4P12pYse22IQ839G8QctGDk0c
 eWqkyAimizjq2AvPpEjRM6t2c1N65pl6uCmYuSiTciaURML/gdr5N80Ep8LgEbAmOYLV
 Ej/557O7fqYDr8W/czvaJJSLEnx5cIK+XY9kJt8GdMIDToOid9XvrW7ZQ4TWf/FjnYQi
 0mZ9Fl2AbqpLJgNb57RlFKcZxUGX9tHp5OV415i0tyw5HakX07ajPV48u4SGR2URFxS0
 htYg==
X-Gm-Message-State: ACgBeo2d9DERyGrPXaLlH+Uq4Fib1YnwCrBdep3Wm9shytC13l6qE/H3
 o/kw5X3o9FovslJPj0eSVHKJ6MZpMf09XgFaKrKb50d5dzxCjA==
X-Google-Smtp-Source: AA6agR40XmT8zh4h31HtNMSrlBjKkdISLmyOpZLVSDQyaRAj4ei/rdAVMIwBkrqkTVTS5Uf2en5n9Pvu5S7dwteMLrc=
X-Received: by 2002:a2e:508:0:b0:263:32c3:9a32 with SMTP id
 8-20020a2e0508000000b0026332c39a32mr9959731ljf.315.1662226697047; Sat, 03 Sep
 2022 10:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220901220138.182896-1-vishal.moola@gmail.com>
 <20220901220138.182896-23-vishal.moola@gmail.com>
In-Reply-To: <20220901220138.182896-23-vishal.moola@gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sun, 4 Sep 2022 02:38:00 +0900
Message-ID: <CAKFNMokhm5TTVn7yGEtwchpb5rk5pur6zog-uCWZGQJmAupoVQ@mail.gmail.com>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
X-Headers-End: 1oUX67-00CdUR-Ka
Subject: Re: [f2fs-dev] [PATCH 22/23] nilfs2: Convert
 nilfs_clear_dirty_pages() to use filemap_get_folios_tag()
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
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Sep 2, 2022 at 7:14 AM Vishal Moola (Oracle) wrote:
>
> Convert function to use folios throughout. This is in preparation for
> the removal of find_get_pages_range_tag().
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/nilfs2/page.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
