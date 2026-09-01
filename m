Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7604C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EuAgeT9d7s3vXcBkLfwXCaRfEig0asTCKV+1XrKw7sM=; b=U++llsPMVb1smy5yCeOFVfMEoq
	89sFMjg7J7GZgJwy/3iTHuKZ0rKCJ2inhGF8tt37bt2TVWKSPswk5uBMP7JbtfnueitOOQBawEK3s
	tEPf5389lEmAgkrYBE7BodwUepAiUVPSjDDcHo7Vy4KQntl/hfMqq5aFQb6Vb9zXxgkY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1RVM-0007qh-Ot;
	Tue, 01 Sep 2026 16:38:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x1RVL-0007oM-5Z
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:38:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u0EQz9qaj+AKu3AT8419jngzyzUGX7Hmro0f+xTswWY=; b=FCNr3w3Oe9nv8EpX0qx6M1r8e5
 7xdI2jliBKvtpY6Y566Ys+6qVvU4LeyUj/SFRwcYH0cNkwpdaG/RAmwVbzIqLj6Hxvw1ixbMUTtGp
 /Duu/jf5xmgTWLvKXJX5utOEim/jgv+gyB/gCeNKyCqxwoudrNMklcsRBdU3GEYp7zK4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u0EQz9qaj+AKu3AT8419jngzyzUGX7Hmro0f+xTswWY=; b=Y++nzRL4oQ2hijPQZHz/2YY2JX
 ltNvgWyq3NlrorCtPOUh1OaXyLqFRsam0pZYouO57B+hYbGHgzB2n19WnP2U/3nKrjyo5AfQHf1Q4
 NEpRr13FD0KqvmtrAXyD9ThXWO+7KWkYc4ajWIOGt1oTWyOniU/gs/4yCMQ0HX0wtcdQ=;
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1RVF-0007Ls-16 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:38:32 +0000
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6a611ba5130so33351a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 09:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788280702; cv=none;
 d=google.com; s=arc-20260327;
 b=c4hP1dCAiWbXEPx3A/8KzMhXdQ3juPUfUEcIRCXq+WkjaFiXdrYYHn3OsdopGiuf/n
 LFHH6l66dV16Jhd1ZNebv2WABNHI5veZADXM1q3aJpi/u9BqxK7JlseZzyr7RQijU6Oc
 TNq6tTwQVELW5PwIZh9MJm3eE743iI+lQTepAjfBQxEr7LH8SxAXAiearGNgU7vu4FqC
 eZz+MnqsqXPcYVuYQmW5VA3UNV3F0nncodFc45pPRPQuVyzKHWP/mzG1602UsaEIdkY7
 pRquDbUy+Nt+TUiQIKKmp072jjQJA/nm7iwD9WYiGOcccxTHDS1HY9ffIl9D7D2QaSgH
 HOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=u0EQz9qaj+AKu3AT8419jngzyzUGX7Hmro0f+xTswWY=;
 fh=x/YN2Z3WGZ9iZP1/MFFGQepSJhdOoWIqq4VdAXaU3ck=;
 b=sHxbWRzmCSOCGdX52Xjxm43r8KYKpuyXO2vbmAX8Ox6pa9tXsjLJVtV5YS9io4EI/W
 PtYG8xmHkLrxUm/ceiO6LOcRaw7MSj9AgArTRFB+Sc9Ny1Z065zjyAksgVTXST1x6RgV
 cQDWovulfvIodabh+8ucpFOVs0csNhG0QpFt10EaBxeORfYERn4Osfk+rIafU6dv1+rX
 Rd/+mF9FNxWMWAZ7HuhQXC6a7oNlnfVT/jno5N5ChrNx9am7V5lguR7/xBZq9QylDChW
 SwRQGxEJx7Ed6KIQ6i211qqFYHxKRzu9CGr2MLCkITT0jlzSvjGclPLihyziO0HhzdkC
 q1/g==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788280702; x=1788885502; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u0EQz9qaj+AKu3AT8419jngzyzUGX7Hmro0f+xTswWY=;
 b=WYMllkp5u+kz0Kfc04Y24b2RzSf/nPfH3x1duk9lSVUz0vvZBT7mKjSqPpANlOAknd
 UHRTuKD9+lnT5+zI8KE69awgETvaQI4jGixc4oL6JGGZeLb1bfNw6HGtbSYcotqnJyPb
 M9+vjBMh/S1eVhQqnttV7LnSDhZbnEJLaLxYlJUP+XzRpf78529bkwaU0S7oF9H+EzSO
 lq5/B95/PzpjgeuavlltoTkgxV+Bfo+/pcr+wTn/6wK5LZf4xVvclGzDqWhUUnwtGVul
 evygFQc2X3W1vUqIHYM444giaP4zB0hNaUhKvHKuooiKna+tJLpuriBmPQM1t/fYiwsu
 R4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788280702; x=1788885502;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u0EQz9qaj+AKu3AT8419jngzyzUGX7Hmro0f+xTswWY=;
 b=MEciSv7BGLYE4BQE3Vt4bHz0rSu3tCfMtAGzPiCZh0/mctbTwa+J14YMpmKm3CTd4F
 18Mi2oUN+UC+cXYAnUqFewn43mg//zYe2wdHtY+fRxeduxqIJD4vnWu19t2Gt0bVwuMH
 FUjqDVxgL6zBtGtynsmwdjjkU8yOTJ/LY/ELQI0cj9LTo3i8qbyOhkDc7lSynCgDCGjz
 gtiy87XOf73dnSBZZDK0VuU/IJCemIEGDvocJVZgwBH0DlwcT1Ff4X7dKh8jINTMddp5
 bv0SVAhfEQhUkUwh5wUfTlYFCr+Mxi0vhNLbdaVdlCzPnzVFsPPoMNDb/nDAWBy20Fa7
 /p0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjz8k/4kGPLXmVLKALKGj8NXGyRg9vw1EGhKF2tqu2gV76BjgtbZbTmYch+3+jMOwFfpIA/QaNpsxnnw5Ww4jx@lists.sourceforge.net
X-Gm-Message-State: AFuF++k84VFroViKVd5Lc8DKitm0WiAtnNelAjndMxkMJHoeToP8cgAS
 2zOzUbjyzmJPFtqgRXdqOzCOwPn5MQ2uvF7f6gNFSE/xW74rd0BOvTu5yy7+6l27JTP0mVEaNsT
 +JyzlAGW6RD0coOAGlZiezcrUKWT2Yz4=
X-Gm-Gg: AYBFou0LP+cmIHfDP2EwKsKrQkeuFIrip3lbMRQ/zF1IsCAEIzQrFCuQqNm4lfSFW9O
 H9A6jch6ODv/BlleXErb1RBdUEL9DRkN/JhV6rQtBmJ0H4llUa51VQmxmW0ReYoJgVm9zROV5nq
 gvXXpYwV8YX5xzqpxm4oaRcPaBkEPReX0f5GXyABkxE318gcpqgW6RyfCs0L4naR6fgrCFgs3Z5
 I95kWfZS+dEwB7jqeps4FfxDhq0hzM/uIwqYy01FThab5XllS17L+TVg9DN+5Kr3RHSdRhwosd7
 13uyPGGbZ7xHPkXyIjFmfuY4Ag/zhMbIMPdz/BDyWjvV+YSA0by7BNFxYXp9JbghqNE1vjwRwZJ
 AwA==
X-Received: by 2002:a05:6402:1d49:b0:6a6:4783:b6ff with SMTP id
 4fb4d7f45d1cf-6a663a0c7cfmr6781899a12.4.1788280702075; Tue, 01 Sep 2026
 09:38:22 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 09:38:21 -0700
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 09:38:21 -0700
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <87c8adb7-17ff-4bd5-98f5-9628c2e344b1@kernel.org>
References: <cover.1788213716.git.zhangxp1998@gmail.com>
 <c570b8ce22c1e2732b3319a4ca9c2642aa5f523f.1788213716.git.zhangxp1998@gmail.com>
 <87c8adb7-17ff-4bd5-98f5-9628c2e344b1@kernel.org>
Date: Tue, 1 Sep 2026 09:38:21 -0700
X-Gm-Features: AcwNN1V1w7TeJTUNgS89fh7liMFDjMccSCxQKWpVFv6_5xgSAnxJyqX9ZyBC_rY
Message-ID: <CAH=xXfF1iiu3t4ug6EgAWp9svPYX2o3GxTf8mDMHCvhWFjotQg@mail.gmail.com>
To: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x1RVF-0007Ls-16
Subject: Re: [f2fs-dev] [PATCH v7 10/11] f2fs: parameterize block size and
 mask macros
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Thanks for the detailed review. I have reworded the truncated-looking
source comment, dropped the unrelated const change to F2FS_I_SB(),
removed the unused F2FS_P_SB(), and reverted the whitespace-only
changes.

For the temporary PAGE_SIZE substitutions, I reordered the final two
patches so node-tree geometry is parameterized before the no-argument
F2FS_BLKSIZE macro is removed. This avoids those intermediate
PAGE_SIZE changes entirely.

Thanks,
Kelvin


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
