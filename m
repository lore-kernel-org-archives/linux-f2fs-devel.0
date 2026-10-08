Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFBCCA600B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=42jUKv4PKgBRekIY6shOPdYyDBg292HTx6BRNIc38Vc=; b=Sg74xC75Ajb4HJmtxwDHe5GgZR
	R0olSR6n8w8fvHJhLbT13qiUK3t/+89R6/aPMmT484NziHdfPmACAEAyi1ztK8lhozw04woPJoag1
	ZIZNjL4NiqgO6/YlFajWltuTNGmHbot5B5QzlppZuNHrC0r/F82bEn/3VAIh4KK9KBts=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xElkx-0000rN-J6;
	Thu, 08 Oct 2026 10:53:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jprusakowski@google.com>) id 1xElku-0000rG-8k
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 10:53:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RdIfW0TB1524JNRu+zC/enwNslep7VME5A2W7emIiNg=; b=aVSn9Z+Ub3xDolMeyjUnUCfLwP
 2S+/8RxzhyyB3kEBdPvUnCR/5UdSydKoVDMod6Z1ugkNl75Ec3svhyagttKSVDF9gSjtkXTWDEf6p
 aGbc2UfQYSQOWc0w4KNRDzgdkafVBCDecqXfQym52iGm17hJPj0XzjtZYNzfCOb05Y5s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RdIfW0TB1524JNRu+zC/enwNslep7VME5A2W7emIiNg=; b=j1ent8FVu8wUhKCaq4KzEdYJ+T
 9Zm8ECqO2FbY6Z43vTzC+hoyNrX8/mWYGbA8dJbjGkSfLlEHiR/P84xZv31SWqPjkUKrrfbdZX6JE
 JahkH0RlkQT8MGEs2e48qenlR+0SQZG6NKH/18cgFNwGZgZ/r2ka3MGgR6I42v89hLtU=;
Received: from mail-qt1-f181.google.com ([209.85.160.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xElku-0003Ql-5i for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 10:53:44 +0000
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-5337c7b9937so273531cf.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 03:53:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791456818; cv=none;
 d=google.com; s=arc-20260327;
 b=h2dl/GeMUotjU/eK6+KjUb+TxGbwt9Y30+jtTtC/Eo9lP5sakEFHmFpbhLY1ges5QV
 FImzp0xF8tKl5IbJ9B7SsQN47JXwzPdZtlH0NkAC7XqLymwrTqcC5z+PHeVzUShYVUVU
 963UUp0kZdlL4CDoUjHPfSm9tUZ5PUMhRWIr8VS4C186/oqL5Ba/fufZNNqhalVQAfRK
 RwydMhGbH6kpuPYk5dnupE+z3fqnDbHKcBPBxZGLmTbXBs+Dv8rMY0aM/+NhpfjkKZGJ
 asOYqBbTm9tH9f/LbcFj61AskwPYS3VSVdGU0P+1Dw5KB+6AL3v/fRxPb8yR8KFcuy9+
 HIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RdIfW0TB1524JNRu+zC/enwNslep7VME5A2W7emIiNg=;
 fh=TyDbKPgI6mxI7qFD5nuHbG897K2E5whltF+19bQiiTE=;
 b=RqlJ9UK/JagrKaIwzIIBKXo+neL/cgI/1qlox20SCCmKq1vSf5NhrFGSPPaKAAEyZl
 rhGOkat7DdDacLi/gJ6Vv2PzpjtGIN1AiV6ZGF0zCg51yUeK+99Hp54rGuGb7NidfFsg
 coGjhxuqyEoxjflPq1YZzCW7eJw7MH0jOKMJZrs//L2S6tZmBr16kyLK6sOxlb6Bbd9n
 NNLuiFwO0UIxuu7b6uO2axwff85mZJRGxeW8pfoZww3+fkWQ0AFu/0gK6YMK4G9bYt8/
 t/tkuLiXXsxwXANH99wfeYte+NAuUHTzf2V56sLjO81QFySc7eA4gz+eq6dTs1tWU8lg
 BQQw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791456818; x=1792061618;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RdIfW0TB1524JNRu+zC/enwNslep7VME5A2W7emIiNg=;
 b=kwwcdqKkppCE8/G2iQmccW00Nw947J2QfqLmXT7Js1hI+AlHh6orkG7yB/pR/VVA0d
 7E64z7GL5mEI66IsNt0Q3SE24xmKawDxMudL8v5AhWem8QKEBQqNh6o3ADfaGV1Bg8e+
 BUAOE//HpK0eAdm0ABAYKcuZHBU5RMJlYESgvJReTX/ydCMAmr/CGZiqLkKtTOkhTKCp
 Araw1+NwLpnxrlbsOTQRqBFsZhXJr/+k9QQh2kr5Sv24eSGZaWuELwO7AuLEcUm2It7g
 u08Jj07wPY1TFP/LVPBUZzongBXmuGwJ1qDkQavBYdaDKKyJt1z05NN6XRSCtPJDmBTf
 at4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791456818; x=1792061618;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RdIfW0TB1524JNRu+zC/enwNslep7VME5A2W7emIiNg=;
 b=JVNG1E0KKm5ZqbfZXwsNI04oV6nNc1CLywm5XnXx/XjT1EkaPrNZ4O4UVvMzKDAp6G
 MP0B7Af2YdtgGDC6fMAlUg33TV3a+cR7s4t46Hsv7qOOBetrzrj7qFa4fORciVDZE5Ds
 GhXPESXwhW6BK9p7jMQdBRdwCZ35ZXcQ3uE0JPCctifZELVT0qILeK6TRKEU2vcRyMAi
 gxLNDzg+WueQX8eFJQzMqAMQ20itYPf4y2agfGXjzAIHK/a6E6nQKbgk2QWsrEssUtXJ
 OvsdG9moQ3nCfbM5rCPFHHVURXuDBiQQ9K6ovZE6mD9LO/NFWWgxAjYBF+NRQf79N80d
 c5WA==
X-Forwarded-Encrypted: i=1;
 AKwUvByViOttic9s4iaYr11F5Nh0kzZEaehQIJPuLPoT4APY+rMnuzBdVN9AP0oBo8+DncnrQF5dPRAbxbDjUwZ0aeDp@lists.sourceforge.net
X-Gm-Message-State: AFuF++krerbSb+96iPV6YoyZPzLh1kp3BKE2sImRDnMNLcgeF/uK5FSV
 Nr/Tufqp66tUkDnu6G1QjgbHY4JyszhC00d1X0MuZUggijU/R8GXsYLyj4T2hiZNnQtnTk4Qj97
 SFDM3MsoT5jgcNoIk5dCjxS3dwYoXSP/xTdG85zrc
X-Gm-Gg: AYBFou3pcqGULFRy65mEGkwSP8g0k6FCnHph5kq4VqnIyHin1bL4pfRJLAT5NdH0TnW
 xShDKryCpLMd8YgMsxqfu+yb2+oK5PJkgUsLLTW2Olmz5SNN1heg4W6TgDRdYIxSZs8yLbmlFJf
 KWFW+NfQm8IWO4mfuOZ4P+MxRs48bvGSQzk0pxzpbysRpAiiG5p11fMGAJsDpnXhQwvtkwHGXCK
 obZMWeUvKxMQOqcw7/gOeGpDKV8jTaLjABuxyw7L9W6PU4w7jEkhRL7BAjfucBEaVvdENPEXpOW
 z8DX5ZliVaa+RUCO+//rNhRxxE0OSA1+9bYWcNQ8//L6KwzUJ3cN4wcsdp38RWtVil3W6u3Fcj5
 Bj8ltcosER3U0MQ==
X-Received: by 2002:a05:622a:8cb:b0:531:282:6560 with SMTP id
 d75a77b69052e-5358ba57e28mr13693771cf.15.1791456817740; Thu, 08 Oct 2026
 03:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20261008093102.2791457-1-jprusakowski@google.com>
 <asdjv0byRIgx2DBO@infradead.org>
In-Reply-To: <asdjv0byRIgx2DBO@infradead.org>
Date: Thu, 8 Oct 2026 12:53:26 +0200
X-Gm-Features: AclHuK8T47iztnOQ3wUy_EMdakQ9CJulz201rAPWZy9Jb7GPVkr9zBdUs-yMDfs
Message-ID: <CAHwWncgG88o3dbhHuHYgCoqGZJ_X8C7wLP0S5ppwRDM450jMcA@mail.gmail.com>
To: Christoph Hellwig <hch@infradead.org>
X-Headers-End: 1xElku-0003Ql-5i
Subject: Re: [f2fs-dev] [PATCH] generic/794: add fsync_mode=strict mount
 option for f2fs
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
From: Jan Prusakowski via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jan Prusakowski <jprusakowski@google.com>
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> It looks like this sneaked into the other tests, but this option
> is bullshit and we should remove it from the other tests.
>
> The f2fs default is simply broken, and the justification in the
> documentation is incorrect.  f2fs should absolutely fail all these
> tests in default mode because it actually is broken.

Hi Christoph, I can see your point. Let me look into it again.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
