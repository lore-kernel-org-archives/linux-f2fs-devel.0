Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21563CA9EC9
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Oct 2026 10:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=90FJiDuLGZ5prjvU1PrlduaaaaOpxtvt/2nkjXBrgwo=; b=cOwJRxkuiavHC+9cDiQPMWrB5D
	w0ZDws3Wk4dAogM+N3TS3SKvj6r+lLjL4sI3B0VoNf0A4T6IPJPkXjtZRwQGkdfCiHMerq8AuP8vy
	zD7BYYE9NZsJiVUc9+OfGhkWV7bF1XbCO+lkPuiax5iG8/1yk2xDYuLYH2fo/BYPpDCM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFqy7-0001V6-5T;
	Sun, 11 Oct 2026 10:39:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jsjlee1020@gmail.com>) id 1xFqy6-0001V0-DD
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 10:39:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DdPSjqLjwJ8SWWsAFmCsKUMaLl1dkxKSs39Ol1fJe3E=; b=QGFdTzTgAWp3mma5yjJfYC001s
 uuGfW0edaLd2TJ8ThnXpQeNtHkITlpIaRi1g/kN766nxx5ERMca+RQgDBemhddBBzDks+2l1lFLAg
 fTxeUX6wpragHCM0qnpf9OsJSBopt2egG3XMZW1hETJ7woisP5rACkzL7SA+hVDHuiyw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DdPSjqLjwJ8SWWsAFmCsKUMaLl1dkxKSs39Ol1fJe3E=; b=mjelHgxib0X5Z23je0KWab85d3
 3GgT0+dw/+qJzN8OVRppRnZOM3VqBSP9BVGtqRpBCy08RjkUwfbsjadICQwMf5ffUcqBqVVqcQMqh
 v2ZxWwr+1pPpO6x0/1PIao2SqVpKlHdpox0udlFL69uV5jf36exKlK3TjoL/0lm/uVT8=;
Received: from mail-yx1-f44.google.com ([74.125.224.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFqy5-00019j-BC for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 10:39:50 +0000
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-67921b515a6so582720d50.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 11 Oct 2026 03:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791715183; cv=none;
 d=google.com; s=arc-20260327;
 b=cyn+iAYBq6dAp7cGzhwuw8LJBs9KMHX6WtCHubidDkOD8x2qZLCioHOczmEYzbQYh6
 GfUXCXzFxVP6mRoj1VxzfNVMNFyFnTerNrOEfdXycp7ChqbgVlq+CIn0D4FPOi7fpzCn
 QZZ6Wyus+8DsdGmmpYzAF/arm64rtOmb72rdVD+eEbi2o6u8obubAe6VREk9brAi8Fjj
 SF1sqfKvH+NJ/vnofJoZFQOT2mw+IC4CvGkJHtjxI0aHIhY36zsIis5rcfht60M4KZ/k
 e25hV6QMuA6XpIVNUCVXLoP6SWQ0a6B/voFRQoOcxE87t2OfR1d/SC57q1atqh9GgGrE
 Bezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DdPSjqLjwJ8SWWsAFmCsKUMaLl1dkxKSs39Ol1fJe3E=;
 fh=qE1pxdKedYKx8ASdtIwwFkQkaGGEJZO0qJ+jNwXegrM=;
 b=DS9dvFur79Rw7WQLiPVDNacru3yXoIl8rE/wzTKPWNM84qZjPTZcjTcbcS2xuSZCSO
 Gocr0utOEWLvtJEMDPlAZi99ma9M0bSMNwf+WjtUBthx54pGxKatggocYAx9iCPosA2T
 2TyS0Ns1fHO10fffyvrZs7H8urdvIlciWKP6NtMl6RxeQykWH+ngdf0BLGBe8RVx965P
 /KcHhc2rDRM/4zv0AqLIMSO3qhk5ugJGtsjOfgAezByrGvAjkHbA9dNgmM10Y6NIOX7N
 7HetTfZdDYXGbxNXHc4sFexDMW1GUr+n3nQOaRNpcRkqKOZlurkYtBa3oLDaU3xc4pN2
 jX4w==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791715183; x=1792319983; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DdPSjqLjwJ8SWWsAFmCsKUMaLl1dkxKSs39Ol1fJe3E=;
 b=sq5MynpxruR0pSE3ShLpgwtBz2sGMoJfgmKh/nkdCZrhxrFYCuX2PmR/fMs+YFf3ir
 1dnAjYkoPFtukin14cD8tKA/v4Gs8waY4ZxScotqUCb6vG4Ln6WcLEuvOL+GeNyHSmSy
 RstFNwWhJ1ZqC6TLTpXxwh0hMI4vEupl6qA8MOBQ+JqPXYe0ZLUH2VIJnRG2AuZ1TVZ7
 QrcJNmI7fzHSd93dWv1HpveRXRoyvZgulErqES4FwilALG2hwT6Kad3Dpb+/etiXOT03
 ZXaGQxUmeHp1PJmC+lJ1OQlUn90LlEXdcwRci1awlG+Jrzs2PKBgjxvVMZLLq8fV108v
 geZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791715183; x=1792319983;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DdPSjqLjwJ8SWWsAFmCsKUMaLl1dkxKSs39Ol1fJe3E=;
 b=ZNz9NxxdnxNt6rA9CpLcXS+Xb0ytWkpYLlYjP3fH7UkQCAgDoZO4Vh47i9hH34ZBkX
 JOP+/0+CWSKGzR/hi5o54bvYkqfmaz/aDAyPVsaReIfvfZjkovwFnfSV94tcCoiPg5fh
 gg4w8Vd/9E3qDQKQ/h/m6Ooe2PLg1Z2jQSQsCMWs0a/sDazbdjJzpTtN1IVjtfIYys2G
 hqg2Zp886qHfU5c/zdyATWAjRuxfAdsZkt/CsZcyDlvaXEU0UzOpDEH1gLI9lucbg1YQ
 7kg//caP74zM0TCJg5pN+CMlYbBVhW54GKrFxlKhigL4F3oQShyljNW9GH2TBS57YoDo
 MFhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+Ad0eS65wjxw0fSfK19PzIw0/rRuHlLtNVtrthe1ctoxpIhywgnpWoFZGVUyr6ROZmvfK4tdb0COz3u5NYJBp@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKjlUDgbBh2R39cPQEszeNKLls/ssyHcrKs8cl6z090pKoSPL4i
 uuF0N9xH1xmJDMrLEzhdcexLBRcM8Eekg/rrV+OvKu5cmbnCMX7HC5HysmHuMQ1q1EtJzpGPT8q
 rVc13SPBnYHuExFrAPvfdZLkjXPv7ajA=
X-Gm-Gg: AYBFou2HA5d2nEpmig+4i54stc5d/JY7oBm8GO/9zfCC5c8r7muHYZbISDyasRqOlPu
 3DDRBL4wi1f5oFKJ0a+bOazcD0whRgNcPp3K+UwCvjdBUdJWhl55vqb1RY8GHYzt5Bf/UwOttLi
 M94up+i+q56mo7aPxoU7ArZE8StX6PqzwD6RO9dgsEnZRCuzLdWyJR7DR7wupAoQHuob990UNqg
 fNTmuS6tlZdJje2A3jVI3mAAnJ5Lmm1OBLOrKrnR60YkEsX/DvcQ9A1b7fWEKqDWHMlKPe9oSFW
 1LuDmB8rjAU2b3owv5hX/55cVwGRec6ftnYcwHDUNz3tNOb/+sAOH/XP
X-Received: by 2002:a05:690e:b86:b0:675:6da9:145a with SMTP id
 956f58d0204a3-6793604eddcmr1958398d50.45.1791715183421; Sun, 11 Oct 2026
 03:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20261004061007.7433-1-jsjlee1020@gmail.com>
 <f3f5fe2c-f0f5-4c23-a2f7-6cb5e09ced5a@kernel.org>
In-Reply-To: <f3f5fe2c-f0f5-4c23-a2f7-6cb5e09ced5a@kernel.org>
From: Seongjae Jeong <jsjlee1020@gmail.com>
Date: Sun, 11 Oct 2026 19:39:31 +0900
X-Gm-Features: AclHuK9A1CW5r1Ejg6ioxpv4j5WsstvSHKyrQo_qEu_linAEn3hxGB5yZ-jeS9w
Message-ID: <CAPHXVrzaWHYccYe+PWLeAf_N3md8ens0UsW7aH-047KGhM4BUg@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xFqy5-00019j-BC
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip further SIT updates for already
 invalidated blocks
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
Cc: jaegeuk@kernel.org, yi.sun@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> Cc stable.
>
> > Fixes: 81ffbd224e5f ("f2fs: update_sit_entry_for_release() supports consecutive blocks.")
>
> This commit didn't change previous logic? IIUC.

The discard bitmap handling already existed before this commit. It was
introduced
by a66cdd985532 ("f2fs: introduce discard_map for f2fs_trim_fs").

However, 81ffbd224e5f did change the checkpoint accounting.
Previously, del was set to 0 when the cur_valid_map bit was already cleared,
so se->ckpt_valid_blocks += del left the counter unchanged.
That commit replaced this logic with se->ckpt_valid_blocks -= 1,
regardless of the del value.
Thus, the counter is incorrectly decremented.

Would it make sense to add a second Fixes tag for a66cdd985532 to cover
the discard bitmap handling?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
