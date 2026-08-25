Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C43AC5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 02:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yHb9U3rRABXzovF1rq4rZ3aCeVsEOMhNvhHI8V4z17A=; b=aICiP9z2YuQsxXygE04ebPbm6/
	YBQMgCu4jGzDdj3Y3I8QXJjZLkBYCcDFm7KgUq07VcvcP5fB+pUiBs0qz5QG/f+Lu5R+TMFbkNCnz
	3AjYXZuNrpbM9/emgygey9cGvTpBccXFpXUPEdfRbgov+r8UCyXgG5Ah5EfLxWwYydWM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyh4e-0006eR-Ib;
	Tue, 25 Aug 2026 02:39:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wyh4b-0006eK-KL
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 02:39:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gJnXzCypNDiyr6ZUvvafmDPxSb3mbqx6Nh1474O3u84=; b=HzYoM+LG+AoxTc8MMGBMRlDT4w
 i5BB+DaHP/Ag9pu51/vSjECXOGty+rAwG0FKlm8bf66EcFB/CBVMb2B8TDZv6PYWRrbVy8hZXBfN4
 9/aH5x07u97m38aROAB1YmbjrbwnX4McWOA6btF5CUqGOe58qkmUwb90azwyi16PXzXk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gJnXzCypNDiyr6ZUvvafmDPxSb3mbqx6Nh1474O3u84=; b=LkVeEE+uykzUMRGbmPfTicQ9m0
 OQnnw7isivSWk9yyND1gZf76Q7uEe9x83fDmi2Zp/b15KgE+zN8/f1SMcJ6OscJo/GaaYSBzKznDo
 hOB5DkN5DF+ucOfacIdtlUGYb94YZ9i1pDVKZtzefg6Rh7NTgfYNXycLSSb9Vg4Evzt4=;
Received: from mail-pf1-f172.google.com ([209.85.210.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyh4b-0005Lk-Vt for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 02:39:38 +0000
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-84fa3b14ee1so3343878b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 19:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787625572; x=1788230372; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gJnXzCypNDiyr6ZUvvafmDPxSb3mbqx6Nh1474O3u84=;
 b=rlGF5XTfFj9b6JWW1qvUKVvEtdxGOhX9OQGTiakzS5JiFWqrqKccvPcuJJKf8FNq4A
 2+SM9u+kb35rruP+WPCsyAu8BmzVTsZw0BdYrei5u6Sx/DmC8c2LvpiC5/2DelfM/qKa
 ie50sB4SYZo5hgbTYO2Xt3/yUj8pp80usPVDnYnZDwODvrP2Dl4jI273kpfOzAUXikjd
 L9RM3N1wX4iRBUkfxKbCCtbcA4k6EDjiHGOTFl5QROhg95pG+dzadgut5YmakCvuYSGG
 lYJ/lTuUpPXDSng1+00hQOzqVbePgPpRQQYkJqD9L/sZejcsu0DyIqC4l9pl6mKumikf
 KeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787625572; x=1788230372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gJnXzCypNDiyr6ZUvvafmDPxSb3mbqx6Nh1474O3u84=;
 b=ZPnJZ0FGsT3/Lj4Y0V801lEgLnlEXLZ1T/jUJ1n/N5tM43HQjJ4EojDTlx/pvaPkng
 HXhKH6S8N+TeF4W+7CpXTSvoLdbosCPjbUxJuQHF9PtsHVUA38E91/tx+w9nvmf1vgbb
 adD5PRtrhnJDOiciFb7yYqlGn4nt1mqXtkY+WFsY62CpopmtTd3d7q5L+4yJkhZ69hhM
 Et42IShx/zMcxyfLAW4q8PgiWlASJjMp9OqwesYGx2GEscb5R4saY5K8w70FUm5URLPp
 Fyviwi6R2lZMYqrEokJC/ZB6fY2ljnZ2YM8CK0vAVbVgkLVOCbmGG/iK8OEPK5N3r+bG
 qT5A==
X-Gm-Message-State: AFuF++lKUn046nW+7j+/QtsBMyZEwU5R9NEWY3u1BRtYeXAB2DqSnEwC
 q5A/BZ6f29VKDkfriOL0fljGCyAyNnURc9YRdb8UXHO2Z1BxEBojiRls
X-Gm-Gg: AR+sD13ngWqLkeHzVQmoSBPwkt7xkFxBQIoVLZIpgGdnUpTzLzb5ctV0iDuZaINmxZY
 s6I+em92dZAofmGadTt4mnsyJOKrvwkH7XY0E/EUzMrsiHgHW2qIRvpXBu1Yx4pY9a4gR0FMjqi
 TRTuv4166POoDTHq/2oqBdj4iwY4KNSfgKxShz4vNFi2GcdDOEGdSaz1nSUXEWHVFTNlGCzMVmJ
 yL1Y1nOrnEw0/VmteTOROFoImjLySLqV07xRdB472V58+G+k0ywER+KNzT6AY9WZs3IRvpL6Oe5
 RlGDv/YqsxuEO/QFUqZUDeNGZmhrDcFJE9i/W3tgu5Sv/mFiBvQnPI2DWCeEo/aahQ1tm8K4Ros
 ZzNAs4lWg6yEAOEHq1sRp/JDj8iY9SKZE/b+faA0/57xq4Fak3A8j9AFzr9POQYV9Gr+xwDJiWS
 xeaUS+wk6pMhxE5P5ggIO6IafD6wiH+P6+fY9ZdZy+iC959T3vovuzg6r+LLinnz4qp/5O+i+ls
 tcet0D+lhWmv/v4nCxBAeTx
X-Received: by 2002:a05:6a00:4c0b:b0:848:76c4:fba9 with SMTP id
 d2e1a72fcca58-851f9cd4ef3mr57099806b3a.7.1787625572257; 
 Mon, 24 Aug 2026 19:39:32 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8520f14a418sm2574464b3a.47.2026.08.24.19.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 19:39:31 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue, 25 Aug 2026 10:39:25 +0800
Message-ID: <20260825023925.230986-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aoylp9llX9zlKm-g@google.com>
References: <20260818200121.2684318-1-jaegeuk@kernel.org>
 <aohtWfHNbUwxoQg2@google.com> <aoylp9llX9zlKm-g@google.com>
MIME-Version: 1.0
X-Headers-End: 1wyh4b-0005Lk-Vt
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: don't leave the hashed inode while
 it's unlinked
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Jaegeuk,

Thanks, v3 addresses the two error propagation issues I reported.

I have one question about successful rollback in a DIRSYNC directory.
f2fs_unlink() runs f2fs_sync_fs() after __do_unlink() succeeds, but
f2fs_symlink() calls __do_unlink() directly and returns without a
checkpoint.

Since f2fs_add_link() has already completed before symlink construction
fails, could a checkpoint between the addition and rollback make the
addition durable while the deletion remains dirty? Should the successful
rollback run f2fs_sync_fs() when IS_DIRSYNC(dir), while keeping the
original construction error as the return value?

Regards,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
