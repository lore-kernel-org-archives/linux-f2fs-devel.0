Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED65C624D5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=52rjA8OvzxJeRkzoqui2t6aNHFVOjKzulzoDfWcqqNA=; b=EIfzQMzAv2t/XTBf/H8E1idSFu
	CFfnuIQrLyINVQH5z3c18yvj6+RTfMLjIFQtTUEa1wdaSnBZmeN7EmGptS4Jp5b5XtuT0+ea0P8oW
	KhaEEasi25t+SoZJkb2VKaYlOOFkSeH+RyrF/AzPbid92oryGnuiyWPQWwilHFDPEo6c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1jcU-0000e8-5K;
	Wed, 02 Sep 2026 11:59:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x1jcT-0000do-1g
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 11:59:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=71/4J9V63EhpSKyZ0UJW2JBEz42BoicMEjCAA+zLsxg=; b=bFaAn+w1qF4r363LG1IWbUJByN
 2a8g6I5WsXjSUCgTbXl9PXNYOpK4urfmCiEbliMv0ixKSf0p8sXsjvir2ghMKeWFOHPsOV0w1+H2d
 v1b6ZIi7XzGxH3tnf/ctWnWD2L2KGiebg5NsuHOSvmtrL8ZtY0MpCGJdONhL6StW/bkM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=71/4J9V63EhpSKyZ0UJW2JBEz42BoicMEjCAA+zLsxg=; b=b3MXG8vxjRPXA3CkUbmdViqaHS
 qM936+B8nf6EwKez/IR0Edl2mVmr2OrT0dxr/6NvRSiozkZKhSknGkDEJuzXiRpurdXjmTvfOd/FW
 /6+Eh6aPOltKtoFN/84NR1nv8mNT7EU7UUD/uqYgyoW0/5ynT+SBFJoA2pFfGQaSn/rA=;
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1jcS-0008Si-9u for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 11:59:09 +0000
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cbe827e3cb4so1190265a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788350343; x=1788955143; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=71/4J9V63EhpSKyZ0UJW2JBEz42BoicMEjCAA+zLsxg=;
 b=MBpTouVJi1MpuZTWpKOgpvXRfp8rm9o/pKSavgKD38glIoUBzJ2N4nPiK7FtWk5Gwt
 rQUfPwcX3sbCI+gZRbQkhIICznLWTkYxCix9wW7VNHjtJutmLHQR0LMDnrAhMOOtx7rY
 sjWhF/Roidoxh0yK4fWxponX9c/RU+boNuYAI1hTLHjqBmKpmh2XfiXl6mjWdOFCtp96
 WQ87EOuQNih4S6JlD5oGAeOT3ZC3YpbzGSRp+QPHuSnQwNBplL3SkTxTRtuUhaoroo0p
 iRRDAvD8s0MXry5kLnF6AdQ/JZesh8S07tytN0JJhwpzqglKAx2VMXE0yaLu6v1XswTo
 KGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788350343; x=1788955143;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=71/4J9V63EhpSKyZ0UJW2JBEz42BoicMEjCAA+zLsxg=;
 b=lLvH+CbvhJlCjlDzZ8vz6h+mWWghOngYG0+WKu+A+TKPKJI/9TerDX5BfQ4k5+b5pT
 7D8fUbNlBCeeWb76xazwCwn8QKD6M42fm1gGW4l+S+Yj1Y37kkbyGO+D+cs/0MvR1SI4
 SqLc+I08NFhM1676KVSP1LyjUG4AQVrwLCYsWDotgeccoWWMmg4ZTXiLbEzv3A2vWYAr
 vXKUzoVdgC7FkopAWAQfx77Mulhdlz3TOfvobBRpa/DDoordtFe1OPyqf5/ZFCH2kfjg
 edRW3KeHXYyRL0dtvzuY9x+L0wEqfKXoFPkUj0fkoa4NBtvMADA7eSQ64v8yqbPSiii7
 f5+A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpomdUqNe/EsR8xMLISadoGwoBTTV3sMRoUYGg9MAwE29TcM0MOViD5lzQ/QDmdSf+dmHBJhjUkWyDZRrzQX6Jg@lists.sourceforge.net
X-Gm-Message-State: AFuF++kiBtAYWHA+Ek6+bLQIrilBOAE5Zgm7XGrbb/12NSD4e4oi4wwd
 cFo1ECmvSfPm91z8CklziLSUUyyJ5x97pSP2EPivKFcbtcXy8AFvWtz1
X-Gm-Gg: AR+sD13y01BaJUZVqB5Ib0LXZDQCAi3ZpHnrXvftDfO5MNC7GvtkMKjfuf0sWXqG9bd
 UTyAhljGK9ZONob1Xc6vpnmqcoORkaeGHUCoKOvDEKUdUSPYq+OZ5Uf1MQKrrF+0B4WGWazxSyR
 qCQTp8uxEyakG7BRG9D1nNFyrP9qbkyN24yGOwsoirxS4kCCLV9unUCLcUpU5YwEgIF+vii4BmM
 7zMF24v9OWY/p4KZLbsR3fYTxtpixoILvdx2tHjojKb7Sn4iHWg+cJiu8IQWSVoowGCm/f+t0Mg
 NG0aH3KP2DDcrLi5GRg89aCvpfbFYVjOrDWWrVgQb4NUHMCAnBh3mNOLn+2i512J5kePbnXSTWF
 MPB/LFTtVF3uF4asCXikIK0z8HjoYP0DuPpORyLsrNV8Tfj39qvlRLIwgWiPRKRtJqB9IaES+oS
 TJ3WzfB0keHcWU0BmURt4l12Zjd29kqdIq5T4aO7jC0mv8+xm+T8/0V+GK1asMca74dIuMZfYt7
 adhyu9gMKvUmFHJjMfRqSdM
X-Received: by 2002:a05:6a21:4613:b0:3c3:7ac4:dac0 with SMTP id
 adf61e73a8af0-3d9af9ff7a9mr7306617637.13.1788350342526; 
 Wed, 02 Sep 2026 04:59:02 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc355c934a3sm914372a12.29.2026.09.02.04.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 04:59:01 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Wed,  2 Sep 2026 19:58:56 +0800
Message-ID: <20260902115856.692764-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831092227.739737-10-chao@kernel.org>
References: <20260831092227.739737-1-chao@kernel.org>
 <20260831092227.739737-10-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x1jcS-0008Si-9u
Subject: Re: [f2fs-dev] [PATCH v5 09/12] f2fs: cache: use compress cache
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

> entry = f2fs_insert_cache(cache, index, new);
> found:
> if (lock) {
> 	f2fs_lock_cache(entry);
> }

and the compressed-cache caller initializes the identity afterwards:

> entry = f2fs_grab_cache(COMPRESS_CACHE(sbi), blkaddr,
> 				F2FS_CACHE_LOCK_CREATE);
> if (IS_ERR(entry))
> 	return;
>
> entry->ino = ino;

while inode invalidation reads:

> if (entry->ino != ino)
> 	continue;

A new entry is inserted before `f2fs_grab_cache()` acquires its entry lock.
Its `ino` is still zero until the compressed-cache caller initializes it.
The gang lookup pins the entry but does not lock it, and invalidation compares
`entry->ino` before `f2fs_truncate_cache()` takes the entry lock.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
