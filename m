Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2030DC624D3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HPhut5MKcZgmKlJVz/dBZwqYLmmotJWjjpg37T7fT2I=; b=OEamGmtFdnfinwjTNnypmwiTJs
	ILxYxnvMX/y4HPUld64yzvaEsufkD/y4IEPLyB3IZrX9UNt4fXXh5WaGSlH8Xne6LVtbqGZclkh7W
	Ni6iz9H2bdfAHJvzuCJtsS8YpVxVyF3KlA0gojWB3gwSqTo44geLnVI37Oysn5SOk/Sc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1RV6-0005t7-WF;
	Tue, 01 Sep 2026 16:38:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x1RV4-0005t1-Ap
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:38:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JNwhP61TrUAZkMFjU8FA0D+Ek1IKBmlx28Ukz6BRrvY=; b=ljLWwQFXv7i5zE5/OJoGAtO0LA
 CIQA9q5onWK/H7BiisO/otaY8Q5wiBL9nGHZ/LN4FjKQ4h9KhEbYaQMIaJkpDmRWBZ8cAgd5HE7fX
 rtFAHHBw59M+gtUdv/wDwIkQepDtps1i7daKOKNISwjUJDBHDP/QurJ5/7L3J1BhlA2E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JNwhP61TrUAZkMFjU8FA0D+Ek1IKBmlx28Ukz6BRrvY=; b=bt3OFvSxcP8/0ZTr+jI/AuBpCH
 qIc+TpuNZFrmI1fzxSvC6Tmi8xBK4n5q22vIsCK627wVvXH9jwqsnYjrNc7bhAr2K7Fe9KpZtbTmu
 6Yuwt4N3fSZpkvuaIi8bRos2FB3p16wlHHXvY9tVKzxEV3ZHEQUflEEXftJ+uT5YrmpQ=;
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1RV4-00062k-CT for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:38:18 +0000
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6a5f968ada7so60345a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 09:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788280692; cv=none;
 d=google.com; s=arc-20260327;
 b=JIr5cnlK4uQoUqIeHR97sRulcZyn33gs4jpQnZcOfZBAu/kmgqS9RtkxaUzjrr5UHR
 ecxM5RhdswuAEQ0vkYhqJbWLMCMlDgbl7l/aSGxBo4YrKo1QszT005eLCLXZx92x+LsH
 mVestcytnVd7SVxRGbo/SxQGIVSHF9GA0sYEnr1bq0POUzKYqA+w7L8lxMBQfFQeuLgb
 9Pw0LtGldhaUw+dIJfE9spDjnso+fUtVlbtSVziyj2RL6cLTTKDwzDwv5viat8mzFrkk
 +msWESO8qOHM40feVK0X8s/jR8nkU3zPb1F/wNzsojhCsAtnjclD78VtTXtRM1a0U603
 D31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=JNwhP61TrUAZkMFjU8FA0D+Ek1IKBmlx28Ukz6BRrvY=;
 fh=ZZyEDQQrpMGN+93C+nWCKA85F8NlBoZRGypE92/ZoLw=;
 b=N3WQ1oNY5is8P3blMG5PkII+DvmZFG70RNZIkQlUco7gNBK8cviHCtpU2e2mZZlguO
 n99OVQmbSGGqWLSYuO+wf9yGMlYoqEkb/exccvQ5SyKf3ppqzu+6cT7WyORDYI0k9kXU
 LKr+4BU8oKFWtnbOWbTOJqycTxjkhYIFAHRRSp+mAo2LvXGKbAZ04RObvnxIsemAD+q4
 5C2pD9MuS8xahumetKOTOT7a+GoWk8akhtAf1ojOGwctfwxNAp2x3Yw9gJVx3HBl+r7v
 8E7MI5miPmqfV8uPr6EZDN0TuHRFvo8PkVY7nER+qPnkd7UgdS127+l1jikRhztZqikA
 aLkg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788280692; x=1788885492; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JNwhP61TrUAZkMFjU8FA0D+Ek1IKBmlx28Ukz6BRrvY=;
 b=oQQlsxnRvJS14yIQZsimn2biI8IytLU0DaMhTXe6EskSzz1Tr3Y5w3npoDkRFhKYLT
 RdXcvWTpL8cIT8lG1wi120Ng4PobclW0BvH9QFhvj0Kcm30I80SRFLu7q0xZz9bjgcUt
 S6RxDlaMhUd5fvvnq62HAAE/DKWdDBp0c5yu412eoV8yGOA2I5YFF77a1kyoylFPeXwX
 BiM694q96zYF2613Ga3ZqBaIl9gS91ugVm/14vDVKsLTKkLzax9ik3fV7c6k0CfelBvn
 C0oAIWERn34XeWzKCLkkGv9f0sTAlyFuw5vy8qHUnO2f6LGrN7fByEs1TfmZ99ecYG6U
 +ubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788280692; x=1788885492;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JNwhP61TrUAZkMFjU8FA0D+Ek1IKBmlx28Ukz6BRrvY=;
 b=nwecnPxEtLqIrH3RLOMyM6zBMZBQ5vPpifkzs6SnLoqZFnxzZuq82+fmHPWfPjnro5
 yEB0XsCg1YpfVeBByNNkUypGALcsiKsww3IE4H7MxNadeydz+LIoM9LCEYiheqgrUsIN
 XK5AYbsMoXXGqiEwnNZDealU7r/nKkYlGvXhksqvo2caDmDtVfUedAQNJoNTCvHY8Ute
 LXMgkbT5T7JMcUCYQ9mtz6ppxxKSaGcAKh0t9r6vtl0bi/9Rw0Phis5GAaSykIEjV7ip
 rGzlAOItbMu6OT6vP4v0vPA1JVDWVPBM3HC0HGniuh3UYsq5rYEQhU1NjOByJQ0TDdpE
 GrHA==
X-Gm-Message-State: AFuF++nQATYuVXYaVpny0I9xM1A/1fOaWL3Na4oxbVwEFZfCATmaR6+b
 7BP5/Q5vusq7Y7vwv5MubsGFoKdpaYtOED+u89gotpNjh9ZW7X3gxVy6PHPe9aX5kXmd+9z/TWd
 FG3KbJQTOyLzBoVsyiokR3KfMVoP7Pqk=
X-Gm-Gg: AYBFou1nUGfBRrAIO6yqyFu5qqZbPBzTzhbgwNGWVubb2hYRaTmV9blW/6lxAT6nbFh
 kPRGn9GSAgtM4J9kLUlqqLYFKZnQgW7fjxnSjD52Wz3wB0tsC4fyx5GI0R1a5gHfay9DXgoQzDf
 kmY7EYOW5q+xDd9vqANhOmuiP4jllOii0DhIRnWa/Ei75BkQGBS1vLQcEOyPA3lSIPDCyKt0j5N
 ojgLSULnNRcxJfADHWEvEU4O85fGgRVljGRQKgIwtnXmyQOkWqoX7dSWQcOX7Z2g6A4teVe/oLx
 je3frHa5z2vatZ14QsSZoY5hMV2fCzYXvbv1OYUMpXkZWpMFGyveYTq3kB7TX5BBnr5L1nAVZ04
 35w==
X-Received: by 2002:a05:6402:428e:b0:6a6:5e8c:f3a7 with SMTP id
 4fb4d7f45d1cf-6a66a5b8ac4mr5103966a12.3.1788280691618; Tue, 01 Sep 2026
 09:38:11 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 09:38:10 -0700
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 09:38:10 -0700
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACOAw_zvPTBFiHwyL5XHwmtxEE2nusoxRtBhYU9jfiRS1fO3KA@mail.gmail.com>
References: <cover.1788213716.git.zhangxp1998@gmail.com>
 <a21bc0d17ce657d0ccd86fd398785b946fa268d6.1788213716.git.zhangxp1998@gmail.com>
 <CACOAw_zvPTBFiHwyL5XHwmtxEE2nusoxRtBhYU9jfiRS1fO3KA@mail.gmail.com>
Date: Tue, 1 Sep 2026 09:38:10 -0700
X-Gm-Features: AcwNN1Wo52nyRIzba3WUWMLzKWdkKBUw8H6j_cq9ZI6VboRLN9QuuO4YUl8YAww
Message-ID: <CAH=xXfGXzN4-Ft9GBUL__VPRJROLTSjBS6ZN91iR7NNOtNgXhg@mail.gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1x1RV4-00062k-CT
Subject: Re: [f2fs-dev] [PATCH v7 06/11] f2fs: describe {i, d,
 id}node block layout dynamically
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Agreed. I have replaced the shared-header macro with
F2FS_DEF_ADDRS_PER_INODE(blocksize), while the kernel-side cached
lookup is now DEF_ADDRS_PER_INODE(sbi), matching the other geometry
macros.

Thanks,
Kelvin


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
