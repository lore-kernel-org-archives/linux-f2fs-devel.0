Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A0BC5DF8C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0E0jM9D3AyJiGLpqSzsS7fB2xbRx91cQH9bflQiGP7Y=; b=Wf3SB86L7ndFVR8JmhXt39wuof
	oN9m4oH09BnwrvWyG/HlL1ivmwyop3f4PT+u+I0NBg7dJyGAUVp0lMU5tG+GFAF0jdMOtUEsmXm6y
	aKKWX138Gy3oItlWrkQK9biGISvdn2QRn+saekIjkr9HWZovFQGMNFzqSzbBjoV5FiGI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wy4wp-0001ql-Oo;
	Sun, 23 Aug 2026 09:57:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wy4wo-0001qf-Ei
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 09:57:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wMkQSb6usfdqVtRO5EmCOv4Cr7598iS0/xLsc7+4U+E=; b=ZgqKN2wnlyIYpN97DtB9ccLzbU
 vWLG9LR1/ABvkG3HmMZF6JslWeCL/W6yC97wAk5aitN3ar0dWIbAxlGvKm2W+FvVEHj7x3RLZkxs1
 lyqgTFt2FHnTVlBpeI8NkkpdpKNOUT4Eg4zN64EvY8hZXEKTRuD182e0jWj5gGLW6Ous=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wMkQSb6usfdqVtRO5EmCOv4Cr7598iS0/xLsc7+4U+E=; b=bOC8cBON6fnVdp21E3sExnu5M3
 neUzHpZPPZXKGGnE5ZctHHEqhESNdbJQYrNsfzFTZIwkQoH6Zad5rjZxzKs4A93AtxfkCwkppiXCi
 5nea3AQvakmnyBZDjC1w63/nbBtKeDJaXDrv+zIfA4xxBEAYcphss9H+K2IEuIwjWE84=;
Received: from mail-pf1-f181.google.com ([209.85.210.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wy4wo-0003p0-QW for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 09:57:03 +0000
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-848643382fcso2431407b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 23 Aug 2026 02:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787479017; x=1788083817; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wMkQSb6usfdqVtRO5EmCOv4Cr7598iS0/xLsc7+4U+E=;
 b=bHgXpT+u8l+WtOd7bRtsNlMMst0oMTaSJDhtjzpOaWu3V8PZBaqJeUq2oKDSzOPluG
 z7uRRj2wf2f7o0aDKeXt2HC5uF7J8SRFe1pMnsI/5fB98WY70BMsbIbVtSNxCyo6MtW6
 auT1Ef9IMxF/fmenqwODc4i7p0l2FEEqftmpJd1NndO7eCT0xLYHd2oHSGyVjL1cB4rG
 o2WagrIf3SwTqkBWuiUtbvnhk/AsiruIqR0uAO7oO7ShqXdmKAnbqXJh8d53qO38xOAn
 LlX2xqipfnEg10fGw+Ig+JG79tXZ0KjC+gauuhKUN3bWiM4oqUF2B+7ok+FcsL8TPYwV
 GFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787479017; x=1788083817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wMkQSb6usfdqVtRO5EmCOv4Cr7598iS0/xLsc7+4U+E=;
 b=p21ybplyu1/+xVjFN4QPDL+WV+ROoWOfBUbh0x6qtcrtv7yANtqHBA6PJcXMBy6HDn
 NEcP+HeGyDo4sS1vv7r1b2NJyVYuH2PcgO0cgTDhQ5eQdeGsb6y51/xJzF/nPnxlA+n5
 alIh8x+8Qm6GtpgRlWgvZ+JbC/ZUSY6WpkCPzFigcJmi26DGcbUL4nQQrm6JHOf/PWwN
 97dL2Ud9grkFLvB9e5OGG6/5iFbmouVv0Y5181eVeYMbNuN3W7+PEAe0W0sxCC9UmqUX
 jOddvhQgZlH4/EOgybRldPRJ8wrzXwYVFCk3UVLDbzT71OMqKfhSPMfzlvJ4Fho1yk5p
 crVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkI8bQUJ/KNH/eKfBMjSwHpHemt6Uo6H75tOX4gWeBRM4NHfRjLl+0B7OKJulQMNehumkG2awa3dUF0u4WOZ3V@lists.sourceforge.net
X-Gm-Message-State: AFuF++numMLJ81crfGDNFyqHoz2pwsbK0fdZyI4p49j/Fs3+huAa3WTz
 C7WDL9laWKu1gtRKNjcnKkpKjn17zfyEKe+ZVE2iiWUpDQYtppwWvJnX
X-Gm-Gg: AR+sD106GBG7TkuVJt/3KVeBZ0/LB8Tm+qqRYvlA/hdejmE/FkM6U9ALEECJl5bA9m8
 R6BhVUgNDbx5j4AIccaUq9eJL+LbPhNm0zxCjtMhedCHkeDiugzjpjMbL8HQXSWuHXXFRznXoTJ
 8yh44GHc2BcLfYZLBIxBkhzxncFChWgvl8o4S2eAAJ87Gwwv6EiWw9spWfKFx7dCl00ojmGuZ1J
 5OCaNEhilZbXdfYTJV+CePTI2IprE9yRAqIn+acThBANNNEDd8PfiThn9hsycIn8oDgwxfbJX4y
 PQvE7nHKrINCI2qzwox+nN390a1TygpkjxYGV4KUUtlLR/JuS7Ew3iiLlIC6fYilND3Xe/CO/e1
 QSwcaedSq3uZhY8ZIabwbUBv9FRrvYp+4N+unsGVOyDH0CyLcrdt9ZdUxo8t+eT+GrYhkGHiF3F
 H5lTSRp+OIGKM8R5Rl79CFbSSCjzA3JAe7sBlB8dlrcuY2Q/1bRl1a/q2BXqtfyZvtRvKp196cf
 CU4UPI3v7IXaQeBeQphe3iZ
X-Received: by 2002:a05:6a00:bb91:b0:848:8619:c149 with SMTP id
 d2e1a72fcca58-851f9a4b0d5mr33867500b3a.2.1787479017013; 
 Sun, 23 Aug 2026 02:56:57 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc199dc3c91sm223262a12.14.2026.08.23.02.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 02:56:56 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org
Date: Sun, 23 Aug 2026 17:56:48 +0800
Message-ID: <20260823095648.3107875-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aohtWfHNbUwxoQg2@google.com>
References: <20260818200121.2684318-1-jaegeuk@kernel.org>
 <aohtWfHNbUwxoQg2@google.com>
MIME-Version: 1.0
X-Headers-End: 1wy4wo-0003p0-QW
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: don't leave the hashed inode while
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

It looks like the original symlink construction error is lost here:

	err = __do_unlink(dir, inode, &dentry->d_name);

If fscrypt_encrypt_symlink() or page_symlink() fails but __do_unlink()
succeeds, err becomes zero. f2fs_handle_failed_inode() then releases the
inode, and f2fs_symlink() returns success even though the directory entry
has been removed.

Is this intended? Should the rollback result be stored separately, for
example in ret, while preserving the original construction error in err?

There seems to be a similar issue in the give_up path. If rollback fails
in a DIRSYNC directory, a successful f2fs_sync_fs() can overwrite the
existing error with zero.

Regards,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
