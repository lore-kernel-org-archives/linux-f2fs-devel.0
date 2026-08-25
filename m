Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B7DC5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 05:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ezVysNchEQ8INb0a0fNo6PIvUO68ymlFQNHW64O6qOM=; b=JtNbDKwBJWNXHKFDGtSl5/LINC
	mEyRNV1ns8X83IV6TZhepDt+y/R1vCjlZOHDpo131z+gnhGztD2zP8wTtCe24wLHg0hC/SxSOhOJ9
	FgsTrlnldauh2HH+iHkl+GhUcGtTAmZDWfJORRTenQcvpicoglEkoKZ2JL0oj3KuHbqo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyjvu-0001kL-TJ;
	Tue, 25 Aug 2026 05:42:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wyjvj-0001jv-8r
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 05:42:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=coIfRXJbAP2osdaCielloPPiOSV8gviUF23Xi6cM144=; b=Nx9jRomgCdB9wa/ON9tDX/sN4D
 UHFgk8qHwbybD43C8icTDxj6tOvttWlemuulzvgRPCvP6Q5bfnMpNTVpybBw05Kh02aPoELLciKfw
 A8zauwNmEg2HNxsOF4MnXmmgLXf+zpov6XAuaXhgPI4jUyjGR2JowZ/PBA2qNsQP2lPA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=coIfRXJbAP2osdaCielloPPiOSV8gviUF23Xi6cM144=; b=VAPAszcHGrSczvu7yVFlQsUFaN
 MhLD7sHPPHlWFNyHo1kCL6d7xlGpfs1IceYZ1MQFuFVz7ykIiaQnP36UeC5DvW9ygD93DfMLoVJI4
 3+KuMAa5fMOMms1y/DAmKiE0EQDMtyeViVuzEsemwYTm0SyV85Pi9HPse7NyTVD4v9m8=;
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyjvi-00034C-QO for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 05:42:39 +0000
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3965d3d9ab8so38500a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 22:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787636553; x=1788241353; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=coIfRXJbAP2osdaCielloPPiOSV8gviUF23Xi6cM144=;
 b=CI6tA6QUJAXzP2XN5dcOt6TnZYjkVW5dclEJ0mMvq9MX9005LbhOcVDa8dS1XyUF6u
 k7wOjytsg3akoCZWCFzReu01fdRhYycYMUs/7ezy4ZXIZ+juN3w90SuGxYXycEAITMaM
 8W0oYknxGKxv8wYAAZtfV3pNx+X0NgnwmNaydhGDdJRUXswSUheS4CwV6US890SDmANE
 02njPovXwCrcAZgZ+8K1Oo2QX6rUC7Dhgjw1MVyfr7JGEeHMpNf7c8cvl7S7ia0wcODW
 A9iT2xGT8Se4nAGQxshwKlsddyYJzII/0Kras70c327JHCFIreWN5Az9iZ9QGbp2bBfc
 OcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787636553; x=1788241353;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=coIfRXJbAP2osdaCielloPPiOSV8gviUF23Xi6cM144=;
 b=TeJQN8D7OBL8O4JfMNQa4xvIYQBo9fCrRVi77YAvJoWpSHcgixpusS8KXo2OjOcRpb
 Ce+2NAi1Obt/BI/k35HAGddh52FA1/lI4OUWXwapTOx5es9xDiwTRy+VKm3FbieP2ZEO
 2yYv7nFxsWZ5kNWxiq2tQru2ALCkFw5v0OaMXALKcMp+V+npQzMuH99CLXRHvErdBsbt
 3J3mEN4BErjyFbF/Ib3/VdYNtJHZG/oJbbGm1tacNFuQjUqA2a/rugm3o8eGXIAbID5i
 MVH1CTdXPVETBulTkltvks4g99lN5TQDggJyRDTc1g9+fQx+GPhMgkOv7TkgsSgT/957
 BW7g==
X-Forwarded-Encrypted: i=1;
 AHgh+RreTDLxI0vaB+YFOS+ZVIaqhHlPJIzwNoA3u5EYFedIArIzNMc0bC6nDucifKrJZyA9LLzalkUuYHL/pLqDrMaG@lists.sourceforge.net
X-Gm-Message-State: AFuF++n2SecJJKD4vzSdTV/m5g2x+c+MZdoTSoAcN2l5Pi0r1ZmX+PSi
 qjqlTcWttOq9AmLKiMkROFxcPc5veXYd2rVo4il01dJwq5slkDvnGYq3
X-Gm-Gg: AR+sD11VtqKKBtsjpo7njx01Pi/rVeEHw+mbWTIezne9GvKOqwGpq9ZoEGPoGgv54JU
 CEnvObjAylAOx2UsePxgbgyyysgQ6UxlhVkrrxd8zha1R8YD8ufJdy9t30NdU68P8Wn3hhVFvH/
 gz90pfhGILg24mu5dPaUBhGHwDe+IfS7vnIUynQZUCVHMSBdJYGNQcWzLqRIjK5G6ObnlDptfqL
 xHyiem377LoTCTQpECqIeOk8yQ+e8fTwd4U8nvUPsgVayU1CbXsMH73IJfyDrY6tSSRHzvxdHa9
 Xxb/SpiHLTuovmFUpg8WdJN3KcgBc6QRcljj/J+wl7uLOw3wdXyPqo+r1j1Q2s86p4aZOY047Am
 Y5QH5RNC1j7TDCMPY2A6e3XQhH/iVEy/vYD+Ks+nkPJfxnvdOihljyJphYpWDYudWELS0PHQaDr
 IiZMimOsEchacw5lMC9E5/2NhqK3OQoBRUJyLJ9l5ViE5OAgyyMEOiB1LBYWKBVqy08k8X28m8t
 dDSX/xtd+FrY8PtuOiItWyYIlIga/REg3Q=
X-Received: by 2002:a17:90b:4ac6:b0:38f:18f9:785 with SMTP id
 98e67ed59e1d1-395df13ced5mr43409626a91.8.1787636553116; 
 Mon, 24 Aug 2026 22:42:33 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396458212absm2409126a91.0.2026.08.24.22.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 22:42:32 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Tue, 25 Aug 2026 13:42:26 +0800
Message-ID: <20260825054226.399346-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824134731.3704352-4-chao@kernel.org>
References: <20260824134731.3704352-1-chao@kernel.org>
 <20260824134731.3704352-4-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wyjvi-00034C-QO
Subject: Re: [f2fs-dev] [PATCH v2 03/12] f2fs: cache: introduce shrinker
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
Cc: qwjhust@gmail.com, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> spin_lock(&cache->list_lock);
> list_for_each_entry_safe(entry, next, &cache->lru_list, list) {
> 	if (isolated >= nr_to_scan)
> 		break;
>
> 	if (f2fs_cache_test_dirty(entry) ||
> 	    f2fs_cache_test_writeback(entry) ||
> 	    f2fs_cache_test_locked(entry))
> 		continue;
>
> 	if (f2fs_cache_refcount(entry) != 1)
> 		continue;
>
> 	list_move_tail(&entry->list, &dispose_list);
> 	isolated++;
> }

`isolated` advances only for an eligible entry.  Entries skipped by the state
and refcount checks do not consume the `nr_to_scan` budget.

Is `nr_to_scan` intended to bound the number of entries examined here, or only
the number of reclaimable entries isolated?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
