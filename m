Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DE2C624D6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AmswqBkFowVnpeX+ylDqDg4ecEPUtgNypwvUJnumUWs=; b=ZIV1Y1s3w+W9sgFYCou9HewEAX
	5sY9YyTIJ+c9p+60X2X5qcIysA+d7yBKP/tE/Kz0Bra3oamcCdTohxR6oHzJUx9y7yhDlazvor4QU
	IqlQ812gRnyKsi+FNArESf9/O0X75Ne3HMVnAWpYajzHmsLT9+XpW1fLVUsADBnrefm8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1jaH-0000Pi-Aj;
	Wed, 02 Sep 2026 11:56:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x1jaG-0000PP-5E
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 11:56:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wNEuPqEuWyvOeNnRKiDgQZ4g2yOI3cJx1FKCZezy4uc=; b=Ov5s29Ic5Pokp6pfcp6ulvC/9z
 eJ0NRVE9jf8mMXJcaF+myCZiaujCAg2eQAoC85SgVB0RcxMEQ0CsiQuBu+vYsgrBSeBuVMlIQSNPF
 QDZwYx66sArzmq/Txi83bjuJjJ7lYylYvynUpDJ0R5DEhEg1rSXQW0yigM3wRXdnmQMU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wNEuPqEuWyvOeNnRKiDgQZ4g2yOI3cJx1FKCZezy4uc=; b=dksTkREESI3xLQ+BWoB0ox3+ih
 VEkOiEdYIZB04tVMgMZSdCzMEgDjaeYnPY+j5wnnyCnPpxPdKY2d/IKfBaZbu9WT66FsWTjWG8G7N
 mjoMxggTvxbW51KGHUqN65R2cn8UD8lcqFm9MHA55xnL3wUsWYc5jl7DuWBZky61UEkc=;
Received: from mail-pl1-f179.google.com ([209.85.214.179])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1jaG-0008Mi-D0 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 11:56:52 +0000
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2d6d28aa26cso5854705ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 04:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788350207; x=1788955007; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wNEuPqEuWyvOeNnRKiDgQZ4g2yOI3cJx1FKCZezy4uc=;
 b=MtdLmXOACG0qhohPDZKjl6VuaBE3As/6f2ohPH0641qyUHyk8ss5rdv4nEFonv3Lr3
 ZkF+HuFIBYRjtkQLa8Z0C6qyIzuikt8G+P1lcaGVTNIeFBZFensXi1NI+0dbMwQ72sHJ
 gXTMRNP40eTm6uUeD4VnyGKOsgq4uaFehHaiYJ9YDBiQ+4tZUke1gyk0YlEt/7asXS5c
 gjk7ngwSqb6kiP5U2JVGfSjxZg/P9mlO8cz6Rd+pgktGAxnI8VwcssILu++IUW+LhRun
 E6sxxiwgzzaC/1X7M0AEMVVkWymjTlWrUxrSy7vpnW56dxjnqRm0fG3nbhUSQZhCE8ls
 MvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788350207; x=1788955007;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wNEuPqEuWyvOeNnRKiDgQZ4g2yOI3cJx1FKCZezy4uc=;
 b=Vtkax/4xT2j8ZdU9UjnqmC+TlkNXJmqvHrn2BdkwRD2kXBpVu6q/9yRN6lg3WoTXlK
 5cXau0sBwG/3ZlwkldGw0e3WEV4RJnDozHVGOgsOWIeDfmiSPGrtFi/R1y9Jkl7KDT4t
 p7wOiL6Hn8GMnVqQ5qkNMNHl2wF5aSgzJG4jxxoW4dpHHBdPoGFu0Xo9mXL71mGHgvw2
 2x+VtJ+kA9ijAHCilxonDV03SN8sMrDj+mkYZZWkhZinSERLkf8XtGjY0XVwOWzFbFCI
 hogKOLtmEnljiM75alGygdz5U62nucR8mQWKTu6dJokmHAXXzkgCde8G3v8oqmlriGhp
 VN3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBysPOU85dvacbsY/aBOiYNaaDT9SS+2+IJPbUXV6ScvjS4Fcs5GSoXpLpxCklWtHPJoA7gdWLipTnI2HHNj5rP+@lists.sourceforge.net
X-Gm-Message-State: AFuF++mUqlgO4y1kbg2Y39it1dUl0bUKicHONESV4d8z71u4LJTLWUFm
 ARX0VOn7u8olK611jfd3mH5yzGZr9ox5a5re+ZFWhNIn2g3yZxTIzAm7yv5dpbOe
X-Gm-Gg: AYBFou0GPqHLVaHh6hzy4dS/VWe2r5pH2CASOuFFIfzrHtb8O2wNz2O264sy/z3lF9Q
 PeWon2Og31aZSsdnb7x0WYSMSjejm/cZXnDPXACMCSZN/1DF/woq+a9fxd++dq9TfQOXjavZrql
 yWv7RYxe6CyhOMhfzn01LOHzBZmOu2C4TsxEUIV4ZgO3HBKsKA/6hxDJfEuB3LovlnCzzR+0kWG
 PG0sSkb5UmAiTkIb4QwgPQsPhSUUh650NOoR/RrF9uK3bLpsqZ9+ArlMrCat8AY8VOQwKZpAPJd
 INIBhoYBp5CCGxa6eftWpy9kgbC+06LG+aiby5dSvEs9HvQq0RhE9/e5VgHKeoOLwZ8KwTZBQhk
 IENsE1N4g4W20oK0b0s7pWHm0NzYEY03Dze0accYWloOyMJUWxdoViL7oSZK7UlTpj1WDGOcCsi
 ZD8p0C5nrcB7p5xauypyDHdG+7m9naHkcH2YN2RgyHXgX3kmjx6imNySYP8igq33n6Z6DQw+/z+
 8535VngV4AnraGLvhQ2UFl2
X-Received: by 2002:a17:903:19ec:b0:2d6:e4ff:9cad with SMTP id
 d9443c01a7336-2daec5ab9c5mr67402435ad.3.1788350206638; 
 Wed, 02 Sep 2026 04:56:46 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dadd488af8sm11847865ad.44.2026.09.02.04.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 04:56:45 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Wed,  2 Sep 2026 19:56:36 +0800
Message-ID: <20260902115636.691796-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831092227.739737-5-chao@kernel.org>
References: <20260831092227.739737-1-chao@kernel.org>
 <20260831092227.739737-5-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x1jaG-0008Mi-D0
Subject: Re: [f2fs-dev] [PATCH v5 04/12] f2fs: cache: introduce writeback
 thread
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

> static int f2fs_cache_writeback_kthread(void *data)
> {
> 	unsigned int interval = cache_thread->cache_wb_interval;
> }

and startup initializes the field after `kthread_run()`:

> task = kthread_run(f2fs_cache_writeback_kthread, sbi, "%s", name);
> if (IS_ERR(task))
> 	return PTR_ERR(task);
>
> cache_thread->cache_wb_task = task;
> cache_thread->cache_wb_interval = DEF_DIRTY_CACHE_TIMEOUT;

`kthread_run()` wakes the new thread before returning, while
`cache_wb_interval` is initially zero.  The worker copies the field only
once, and the sysfs store later updates the field rather than the local
`interval`.

Can the worker observe zero at startup, and can a later
`cache_wb_interval` write change the interval used by that worker?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
