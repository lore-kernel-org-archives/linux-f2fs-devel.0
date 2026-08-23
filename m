Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066D9C5DF8C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 23 Aug 2026 12:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A5oHLGYWu/daah0zNxm5mzu8mA3glqxmnrwwrtYwp90=; b=IUmURZDqyHlsGltB2YgD80du++
	BeTOJaFYxikejdKKnb6OHzVQXb/2ES7tRpu7xIBx598rvCOtvvnO1lYP/YtlYfd4zsbBzj78hrUWU
	kLzno1cpDXXMtP8Tof5Gqb+3AN2rR5Evee/w17bWXSNzc3NohWuink47JOicOHxVxacw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wy7jP-0005Au-Uc;
	Sun, 23 Aug 2026 12:55:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wy7j8-0005AT-44
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 12:55:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9zCA0/hbJC403FfchA3WFskhYQnF5bwlZtDhbVkUgaY=; b=MBa1qnnkeml7Mn/C8f/1FE7RvY
 3OgHSqbByJOZJAR1bLgk54UHHAM/PfSwAfCD4+LVGwvnwM348dbJvK/61tKo+C3QrdX1aZwEWfTDb
 WqgPVtoo823tpIi2V88Z3VVF7B/6JgeN9jRq8PLVssGajWEK2eOeoRjpOgrpoB9rrb0A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9zCA0/hbJC403FfchA3WFskhYQnF5bwlZtDhbVkUgaY=; b=m0Nqza6tKJ9ZEgIMfmuhDz0vHG
 Z5epiR5dhNsTSmVD4n8q99ZNQXjzRJipJGU4REzczNJjgqok00/p8EcG7vRDPUmD27xTnfRRZ7ITY
 AJiOs38HX0Lilmj433R0b+HMOC9Rqt6OcSMqSSbSdaBTF4iLT+rxWSTvIdJkQzoEHtZ0=;
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wy7j2-0006qE-V0 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 12:55:01 +0000
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so2349758a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 23 Aug 2026 05:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787489695; x=1788094495; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9zCA0/hbJC403FfchA3WFskhYQnF5bwlZtDhbVkUgaY=;
 b=bsFlaGvgYVIPX8i8smvabhYZYl5wIlFX+IiPa7nYJLIs8wtbH/MQ3V9FXEtBKtSWnN
 qJFCP+6TWJiesx8Gdj5ZInXoFlWo8+z/V7aUI2V/JZCsUXzbqu9sKCGTBkvU8WYV0i7l
 sTD0wzWyDOVfnytCA6UOPU9GCXAWe/6hVhIMZg8EZOS3ff8Uu+p4Yuk02RPv8sn9Ua9E
 6kTCg3bZlQD93268E1Lu/rTkJk2jOqaDjw6rrg/YRsS3ikzfpV01zb67wqDXlhImnm/T
 S4FZ8iJSNUF+IRkH6tcLw/3Zkcg+izKvqRD/L9MB09Z123SKf4TvdhUFa7wdBxg/gsZJ
 5oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787489695; x=1788094495;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9zCA0/hbJC403FfchA3WFskhYQnF5bwlZtDhbVkUgaY=;
 b=i3FXGhaJqSpLk5jOuqCsZpNiDOxmwpclahxA+nKHTn5RKUJgufKXOyCmw9xIQNf0nB
 tC6vNakNAWvxbnZ2d9SCvjspHjR6ht3bi8ETGi4K4NWdrSnGS3Oxp1ThqH7lGAWpDCT7
 zVD05CQZav5Zehb0WcnTLp8ktkOCOSFqlB+HPJnpzwJPjbCRnwWjFyERbt0IPev73RzM
 H1gBptiGgNYqUmjZRXBvp1FzlpmuYAXBEDki6DZ53Zy86qf7o5l2c8bRPkNmfmBgGkns
 n+ubY/e6IgLxIn0ccLn6Ok1snWY9P+VmdjhXNh+mWDOfomHY24HKCPTaQSVtONgt79tW
 V6aw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrfpPwd97/lbbn1UI73JpcWYAZ0pM2uCYP3SnVUceGr36Vr+87PN7jgOc5UbUdv0t1dSAWYeu5LUTOB44D1XPhN@lists.sourceforge.net
X-Gm-Message-State: AFuF++lTDvQiL/cy0LbbzQgdzChHxsNinDuw61G/AMZ1tQ5m/rN/r0jJ
 PRvkBuMHwUnP79Q59/JEtvlD2QyCAkjzodX85iVIBO10Li3ISfP/PmGB
X-Gm-Gg: AR+sD13lAek+ElxGHGvK9alLuWNmNh3R1eMahDSDR+LgjIh65rUQ5kA+yQuA9kjqKOY
 7ivbJTiT5v/d1CleTOehVvD9at8kJ/h38l4a7YF/XwhgTF83yYRlEdkD8G8GYf3gSUu4g3OJdPT
 9bXx8dp8PLjwnrF+P2vPQfeRe7XCASAFkak4GN3fG9XwqPF5QpEFRrtdg+Wp5lYH2tG1L7MlC47
 oAa19GWndCxG0vPbGgnElP6jBI1I7nc/anPgHVaU1lPuCDX21gEaz/Sxfr6/iOfQqZt0vWQcPN/
 68QUlLnJDBDEFpvGO386jOG+Dgdj+NcwkURfLLt8zyYWNpDEVErr/kPtWuXILHLOvAaP5NGxogF
 QlY3ECgRqAeNURRSuI0CDnyO3XO8ZuSvuJU0z4e1Np+3IVAy4KM0YnmBMjLOBUmOpEr1d46LeDK
 oA72ruVXtW+csN95/rmrGbw6HipwF3V/c855tCPXna+Qybe1waLL/R6sf212H4qoe5MJCrgKuje
 Yq/HRVFRdGkbBzxANIDY5oyHnOdUfM7ZPI=
X-Received: by 2002:a17:90b:164e:b0:38e:57a3:f218 with SMTP id
 98e67ed59e1d1-395c3733afdmr30759620a91.13.1787489695201; 
 Sun, 23 Aug 2026 05:54:55 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e42d6139sm5994245a91.0.2026.08.23.05.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 05:54:54 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Sun, 23 Aug 2026 20:54:48 +0800
Message-ID: <20260823125448.3228967-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820031721.12218-5-chao@kernel.org>
References: <20260820031721.12218-1-chao@kernel.org>
 <20260820031721.12218-5-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wy7j2-0006qE-V0
Subject: Re: [f2fs-dev] [PATCH v1 04/12] f2fs: cache: introduce writeback
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
 linux-f2fs-devel@lists.sourceforge.net, Wenjie Qi <qiwenjie@xiaomi.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> cache_thread->cache_wb_task = kthread_run(f2fs_cache_writeback_kthread,
> 						sbi, "%s", name);
> if (IS_ERR(cache_thread->cache_wb_task))
> 	return PTR_ERR(cache_thread->cache_wb_task);

After `kthread_run()` returns an error pointer, `cache_wb_task` retains that
value.  The later startup and stop paths distinguish only NULL from non-NULL,
and the stop path passes a non-NULL value to `kthread_stop()`.

Is `cache_wb_task` expected to remain an error pointer after
`f2fs_start_cache_wb_thread()` returns an error?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
