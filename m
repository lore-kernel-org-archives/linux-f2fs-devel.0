Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD1DC88E72
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Sep 2026 01:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mIKZjb5zznb03hTJNdrr9cej447kEDseFvtsFC87Qy0=; b=fVJ9+ZvgzqeP+1cY3wLcyeK7N3
	ZCsEyztigX+lvQpuEx5zdjW80DEca/qu/sdJ2Jy6yRJ8OsLEaqFq13Bg9VpNR0yToCAANjYsXvZhU
	r1hFfevaX3St0ihnO3cLHoXSynZ/xWMTurRLLNAom4WPCoicdq/akv8zNRzsahrAmp5s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6IQq-0006LQ-2Z;
	Tue, 15 Sep 2026 01:58:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x6IQo-0006LK-RO
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 01:57:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8LtHfoqQuWljZWMj5fNvShJKWJ7Eo3q2bY3EGg9Y51M=; b=i0NjBVvp6d2GxpeW0q02ol1J80
 barU9jmbGdgLmUeAabcv12+zvxLWYAES30GzI+jbR7+Ezrkwi/+QBDWAyGyK9fU5Lsrwiqe1OLZNv
 IBkdPlli8A7FzftTkJn9d0eFDAKIRfW5ev4TeRuweH9V3zN1WH6RVxqAujGd/GrBx4PE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8LtHfoqQuWljZWMj5fNvShJKWJ7Eo3q2bY3EGg9Y51M=; b=gAIwn7WVlaFKaZHu3HldVVJAL9
 g+bspRcXVDjJGjafPSmp+55UVmEPYloJ5YfdXsL1A3CbGLHwfQkVBnGKr/7lM5oEtvTzWRWQgIyJQ
 16zJW/kKw9OZYGm6HGxZKSzb0eH10CriGfQZMmMH0OKauYwGTJwi/AlZlC6Bw9PG1aa4=;
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6IQp-0001oV-16 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 01:57:59 +0000
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-86aecf49833so25934b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 18:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789437473; x=1790042273; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8LtHfoqQuWljZWMj5fNvShJKWJ7Eo3q2bY3EGg9Y51M=;
 b=WmOM4ZabGoKKskAZR8kzYP4b9u6dCDX5mzr9ErAVXR0ioh3MzOpqs5LotGFCYIOFwk
 yizHrtuJtM5eEceoWZv+xej9UNDjQc8Ezbdd8UZLpNoQm/GC2sZZj3csTBNvsgj8kwTX
 Yl/6zziRJIAnGDQU/xJkRBtrchH/x6gCRYoUUGxm3/MakKGxWMiE68nYQVOz1JTXYbgA
 7I0KXP4F0iZWN+fzIk7AGRHKsTeSbIzrZihGI2MPdGLqkzK+yxjYuGGFq5vphWw4HEYq
 eisOmodVVP8TvZmMvtw/jBWNvj1DD7jG1VMsvwWDgxQBUXmq0aE2E+tSIjESuZCpbhma
 HOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789437473; x=1790042273;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8LtHfoqQuWljZWMj5fNvShJKWJ7Eo3q2bY3EGg9Y51M=;
 b=espQzPzvIngi5Q5ihIGknLKDPULHTX6R7HJk0NwfwMLSmJs2tM6ZczCrJtci4dathx
 YJoey6fnhQKeqj4Vzqz7dnefFJHDezwACbBtQtxqXUyPDrdLaUx8Tp3KEYHKsvGYMg7m
 Ef7N/heGU8cMxH+edRdGPLyt/AcLoWeMMnEbOFo0+vrj9pFaFpw1aymvkPyppke96yGT
 HiM41ihm+B9xnsf1qIph3nhtekLyjjMyDK3KeGoq23AMmMmecwzJOgKK8YOR7QzIx7M6
 FIjncPW6kiIHdmECrEv29v9Niwb9eM8Qy4W+J00r58m+y7lNEBF7a0U05sbQOQQvNbIv
 QgZg==
X-Gm-Message-State: AFuF++nftJIPHMCRRArIxSv0QLTND8t1Sishv2h8uWPOqoOrojqTXgtS
 HbI70eAwRs8QfR9HSYH0b1wWJF7Fo2+N31VQrGo9sfpAJxTYVHmhqMa0
X-Gm-Gg: AYBFou26ingTuCIWOmpSaqNf9ULp1WKfoIbMrbBM1QH9QaEhtQe1Q5vhkjbCPhWnEGq
 rrCQNdEf4UPZNlhe/95QobmirHigLEIdzL6JQF5r6wH3KTKPdMqeIqBHLgXyAA9Rxg5LwTBO1tn
 CCfWR2l1v8CHRtDDhUJpl/jjnan6YLTIBzHvHexokPeavGAwBbTA4HEQiQYYYJMOI2tc6f7h08R
 6hZ8ioI9lUCHrDt8Nt5QxRxULYc85gVKRsJ2ZnedEbMJVYvLPC7HXZo0NWZLt3EaZlh1Md9QyoZ
 XYE1aGwXUyRpPtrPQtoVndZXzy+2XONZzF/brmZIHo31V1Z7a60gjurdIbSY4YsD+M2eHxTsiFc
 hXU/oq52CP29pynPhuUzwsMAGlsoixMnw64txZ9+IDhwbAO6eCwApgHvGrqMHDZv/82ij7VLsBX
 HlzWIv/Rqsc0NBpvjYZDHRf29ydB3I8PGRM4U00sYK25xtumqYvzMVPselyudWo2dEIB10o7kRX
 Z5zqgMPOC2UE6xIfcLtMtDIZP23bXBa
X-Received: by 2002:a05:6a00:3a01:b0:86d:117e:5db3 with SMTP id
 d2e1a72fcca58-8708c45f131mr2265230b3a.26.1789437472373; 
 Mon, 14 Sep 2026 18:57:52 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b6139e3bfsm5231011b3a.50.2026.09.14.18.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 18:57:51 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue, 15 Sep 2026 09:57:45 +0800
Message-ID: <20260915100000.1789437600-1-qwjhust@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788795700.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com>
 <cover.1788795700.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1x6IQp-0001oV-16
Subject: Re: [f2fs-dev] [PATCH v5 0/2] f2fs: enable buffered RWF_DONTCACHE
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
Cc: axboe@kernel.dk, baohua@kernel.org, jack@suse.cz, qwjhust@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-mm@kvack.org, qiwenjie@xiaomi.com,
 linux-fsdevel@vger.kernel.org, tz2294@columbia.edu, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Jaegeuk and Chao,

Friendly ping on this series.  v5 includes the mixed-bio completion update,
the syzbot NULL-kiocb fix, and the additional memory-pressure data.

Please let me know if this direction is acceptable or if another revision is
needed.

Thanks,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
