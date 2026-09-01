Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C813C61DD6
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W+DKrZ/CKFVpcCkFbeFTD3A+WLtrn3MSzHgvhaLF7AM=; b=Jl0Aag/WHjteTqih2xJifRxuPR
	TMOQePN+qOX/WLGQFhc1uIsqS2ftvePArpvdiRGeDwb3ByOpwsGwVamqDP/Tip2BHkbn67yb0L0bF
	OwLfYsQ8P9/wORwVZ4SxY3Mi26oucxUcU12VJ226Wzk0b+u0LU4KDr36EdOxCNqvB75o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1JH9-0006MU-VU;
	Tue, 01 Sep 2026 07:51:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x1JH9-0006MO-36
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 07:51:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xs/mCqlBgr2P5MMu2vHv+vaDaaGAyN68pI/BVuaAGSk=; b=I45B+DcHPQ4Gbh6Fvm/4IA4vng
 esEVnqXRRnMukXvVs1NqXDLFCUkyQmhM/QFrisgdEnVIDnkNrKwYlcts9zX6ofKqVwCEBdZX0aSN7
 SrdxFkUPaeXo//NHS2augm78ivGkTCK9LLtHtSOnjd73C+9t9R65mp8I/r5izxACYtoc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xs/mCqlBgr2P5MMu2vHv+vaDaaGAyN68pI/BVuaAGSk=; b=lDXRVEZ8Osn8UDJobjKz6RmEeX
 ZMcjaGzrZhti3MUpnerORa9gqBHqCZKUFi9lOFFc886dvm52gJNKQyvDMf4J83I2gHONeG8kThSkj
 xnG2uAZy2LcjrxhTjF+R3GT+TPeJK0+m8EyCbHv8PzexARB4b6lQW8gbLH9p0DjI/pXI=;
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1JH2-0006kb-S5 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 07:51:20 +0000
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2d7195706f1so43962405ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 00:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788249071; x=1788853871; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xs/mCqlBgr2P5MMu2vHv+vaDaaGAyN68pI/BVuaAGSk=;
 b=UbwjRBqONhaBIN+aZh24aAzxOnw7yNOfKMPL+FSNmWeUYRnWYxd29ZOhfqUFQqdSpu
 xVQSDSPaBjkjBEY6QNKOSJOym4jXgDT8wvaqMCMDiuRkDd6xTYgGSoInUqhwpHcFo66J
 dfIQ8AKt+k5FOgBq+V3LJmv/adTYYq0uZxdOxxupUO9qiwehf3533DhB0B9DjIyg34z9
 dsuSyAeWt5dcTU1Qq0gsuhqFvg9Stp7B3NCgbiQXlizFiyC3/MuEOu+qkXihn/9L6ZF3
 HVwkZyDxFJUU2sIo8G5d3E9qIBIjl5nUTR8LZKDBYdYnJytlc6xqJ8ZjSxxCk9mMyKte
 lliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788249071; x=1788853871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xs/mCqlBgr2P5MMu2vHv+vaDaaGAyN68pI/BVuaAGSk=;
 b=rnqciXJScUeE9Ld9es8GgEKXao52TJCio+ZS4dE5QAriPArX8OUY+c2ygDXgNixGfZ
 BUXh8U/XNeFJ/ihYdTY39G5ZS2m9bZLalMLIZHrePMsj5LijVHAjZqR1vFebtG0Gs19y
 wZDgUKHfXoTX1iUVsHKV+46Ol1pm2Ku2baEC6qvLSfma3PAECgsiZ6ndEDENm8DPZLrD
 fiFfKXC6JHIEshwkYJ67ct8NuCd8+nG7YIxt4XD1w4iPH4DoHAq3WzJ0KkaMPQgk1q0v
 sy5NYXgDe/PBQ5y7VlpShP+FLLmlGgc3+TBBSKFgcmHynzviVahnNJmdibwD37qXPzfc
 nBHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0oIsbesajsmuI/9zjiE3yBGS5xcpbcEMEHYseAPpiuqIVpmfZnNHdptm8Iu29J4FCUWC+cjn6kIbec39BaQ9q@lists.sourceforge.net
X-Gm-Message-State: AFuF++kMwC2BYCxpKtgw0BaXnZydyK1hf+CzFxkxcxj7fg6heuSxP47G
 JFWZvmdq24R3gNn6HHMR1Oo7teiLPIyI3J6PWLVje+XzAveJIh3DgU1k
X-Gm-Gg: AYBFou2A4FmeL3tIJIWSHQ+Glf6wGsDcqbM+8BDbqWr6vhiKrVPreWs1MbTxxlyX3Vw
 XlgGaMJ5d8fbj3kLypMTeiIxCILI3tvwXHTJchMV41XMIMzz+bl5M9xWl/PNaOA5bjadZJZOYzL
 m4suJMGgx2Y7DoKcyEHp75S3Z37A6Vti3dixWxxuPZLaAX3AuDQC6s+y+S8ygW3kUwkeqzlwdBf
 hgKOdkTEZ0fh4fl4/qa0Kg5BAuAKaQCXcJmkcwQIp6dDdLN5cV/dZ1LE/TWTU7hxc9ntHy8Ly/d
 z4vWfd9Q13kWBySoeZUhQ5vVutCzKYNRtahI+6bsNeARHRZo0ZuXEaolRktnz70r6DXmIZGmQM9
 aNUSgiBpk/avL7/KUhLfs+YIbvJMH30yMHWkFL+waM9cj1EeUdGLROBlgr2391KVl8grEKCqB4m
 3+rQN3fqMnRRuIT+pkaCM43n/EEIiaqSA7jg5WumTFcylHyrj2rMxuA6D8XLDB3j8K7+4mTKY0P
 7vk4mmKBmBsB8fXCg/mF7z2
X-Received: by 2002:a17:903:3d0e:b0:2d8:d4d7:f055 with SMTP id
 d9443c01a7336-2d94a930d44mr91544595ad.22.1788249071183; 
 Tue, 01 Sep 2026 00:51:11 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d7598c3da2sm47760825ad.82.2026.09.01.00.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 00:51:10 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: daehojeong@google.com
Date: Tue,  1 Sep 2026 15:51:04 +0800
Message-ID: <20260901075104.1158778-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901031000.786214-1-daeho43@gmail.com>
References: <20260901031000.786214-1-daeho43@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x1JH2-0006kb-S5
Subject: Re: [f2fs-dev] [PATCH] f2fs: drop pending discard commands before
 reserving device alias
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
Cc: qwjhust@gmail.com, jaegeuk@kernel.org, qiwenjie@xiaomi.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Daeho,

There is a use-after-free in the new helper:

    if (dc->state == D_PREP) {
        start = dc->di.lstart + dc->di.len;
        __remove_discard_cmd(sbi, dc);
        continue;
    }
    ...
    if (dc)
        __wait_one_discard_bio(sbi, dc);

__remove_discard_cmd() frees a D_PREP command. If the last command in the
requested range is D_PREP, dc remains non-NULL when the loop exits, so the
following __wait_one_discard_bio() dereferences the freed object.

The range arithmetic also needs care. block_t end = start + len and
start = dc->di.lstart + dc->di.len can wrap at the 32-bit block-address limit,
and the RB-tree lookup still compares against a 32-bit command end. A range
ending at 2^32 blocks would therefore be skipped.

Thanks,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
