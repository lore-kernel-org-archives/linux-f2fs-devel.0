Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE86C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zj7+m7sbzPjRmgyaSlnik04gn7EtUgE7o35cRcgPeSI=; b=Gu6xrO+ttorAMrEKHD6qnkPZ2f
	rXhjgmEIKuzMuB9s+rp9byET/FRgiBHqLb201KwjTQS5mQQpT4Ad8Gn1HiHxQgs8mcynjlaM7pJaG
	G+Ms3cuY759XhOdfAHMqKboKWLfKcJumwXxOh3DwpYFzrsViWrAOLD68Wt85MzipZ5LE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1RUy-0003U3-S4;
	Tue, 01 Sep 2026 16:38:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x1RUx-0003Tw-S8
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:38:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nOa1RhCOWow5Q4Zd1s2ylWpbZQcLPTfR3gq4oCCRnno=; b=BhgBoXzCQReaJ/laPRGutqhNXv
 B/VftwvoNumG4lwNJ7ZZqu02zHR5EazYdEdD6Vo+1IcV8GGepnyWUMT24JYu6Y4te0P0xtCmpr5JY
 r3qiwYtPyjRFsuWWRJ6OhhXg8+HZIL/s+KxN4Bz8q3+jpSec8O3pRQpR7eoha8MCToDM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nOa1RhCOWow5Q4Zd1s2ylWpbZQcLPTfR3gq4oCCRnno=; b=kbLR8w624pEpjwdMjChtAlxUfI
 stu+7bCuJn7GKR7vXJ9okPOOsx8dbM4mYWrjJhp2ZtVbmsAiIRG05VujI9mPccFOpqrN2KyjbJU/o
 z9NA3CNJbCqZJ4PSzjLpHWZnOUKijV/8YzAy3aJc32K0HvNQJrR1wweqbp5J9l8EQUDM=;
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1RUw-00062F-Gx for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:38:11 +0000
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6a18840e2abso53633a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 09:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788280684; cv=none;
 d=google.com; s=arc-20260327;
 b=ot9C3bKtDIvpa5wpvdCNddCW5H6z9dAZmgKa+IEhg5xQtZ6mtlG/qhGbA58dExDFe6
 UtOwuGJEDohL/PYLrZbcm6DOj0JNlsUZSBuSuPTdZ0Tl86wD4Jp71EcFCJAMYxsbfKIu
 wYd+kjTlv0D2xDaZFr+ggnz3tOQjscog+lz41t7VzPI6dmDQCHF/tyO2hALhSo0GvRSs
 NsnOKE6DPZzOhrC+eLSNywWsu2dbzJK+brhPJe5d79Ua6vdbwOi5yO2rz6SS84rN204E
 oQ+shAlF+DbGACNxRKlWlLBMfacRk3Df2mAL4YVrLe1FIkrsw5nlr+GLiOcokSeBioqP
 NBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=nOa1RhCOWow5Q4Zd1s2ylWpbZQcLPTfR3gq4oCCRnno=;
 fh=kvjpwkBcgEqH3ZekWAj94/WmUzZIE3xVBsEweZe7TwE=;
 b=JL4Nk+nwHVGYURgE6l3o7fgaiswMugj/juKcwH0OIfMoAlM8MYMi/W6nCtr2tvNLeB
 aKKpL64rSsBiRBgaZKiIFxXH8m+ruRB+3zZj0Yiku2A7kDdyYGzNpEvqPG4xHUrDGNeR
 6Jl8cFz/JU52Oy6HqCF9D7ar8JAcwy2dF768TwADpSaGSK9bchMdE7rAW64Q/E8VEsRG
 eyZamNpiMV6vFAqXxl3tl0OUZMfVf5Xfha/1P6iTKJ7pzpER6a1+xL3fIbEYiGjIibq1
 7xRpzx+CrdgFdRWbICqUeGeqWCFwJz836DGZD8xlMsPwD9c35mhIIoqurc1g6B4oiQQH
 jWkg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788280684; x=1788885484; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nOa1RhCOWow5Q4Zd1s2ylWpbZQcLPTfR3gq4oCCRnno=;
 b=gNYzCFMfromtMjqS3kPWggFG2i1+GNV8+l1FqTYfC58BKOTT3GGJ6SpfhZw3448UFZ
 Ad9JtKEHoOh1vKu7llMWszP9SAtDD9hwksfsKY8n/M6QMnl+2599Oe14usNmgwpxo/YF
 akt3v7TnxfeASJHjGLwfGMl5w9MBuK/PaF3vOGUMpD9sDz3U9Sx/2riD9E8GYh4hgolM
 sko6MafkFCxr5vo8uZugC4ZW+Vrjg+TvcP3Ec+3J8oDrQUrDlZP78fr6e1j3bwKQ7OsB
 uujhQ3dcvH2x4Au7LfsgQDv2ta/n1M2unuwpaQDzLSwUOolZIgU265cuB75RkLn0xsxc
 3TXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788280684; x=1788885484;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nOa1RhCOWow5Q4Zd1s2ylWpbZQcLPTfR3gq4oCCRnno=;
 b=Zs6cRNo9U7ajrE8ue631WmVriUM3nTbwNIlhhUoACMOuOPMK2JhBlQTrPUDetm1KzG
 ckstdhxlstKjLhDdBfi7gpAsXqkHtW8xDaUplwVPHJZinC0Fo4/3AxMsSLYcgJl9qM+D
 nKhqQOSdCfVluK1KYOrzK3OtNAwBdxdnJoiuiybMoGDrEG1R/Ry6rhO0afhuhDYPSt3h
 TZktpnNPncYJ4ipmFhYQc4L8e3X7SQdNY4HEW7ygbOiMSVk7oj9+dbPHX7xqgIVsTiqc
 7zZyS+prSL2z3MMGChVZERVH8ix8zN3BJbNaqBguU4WtR84K8Xi/CPV+SYHBnInQAyQh
 Sm/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxfMEDUvz0784gbRtJFnwRiJAZJsTvSayLaPtYqWhm6onDjkuLXpmd2GCEJ+SFGrXxxx0xaNuUN9q6fxww3lDM@lists.sourceforge.net
X-Gm-Message-State: AFuF++k1FJnuk98EikEZRrFq8t/oktv+WU1RZXB7oeUk/FIUmdhJSh+4
 SQKcBb3Bp4LCQZEj/aqpDhEoM3BDpBzD14ttuDfT2F4La5/Ois3ACCuF4ghkhWtHPvbaNMPGouc
 VryNn1tUg7UNbhWQ5+1vtDTLgMXpq0hc=
X-Gm-Gg: AYBFou0nluiTzN5mheeC3ghIdE02Z1ZyEK5epjuIhZ0d0rNkHdhqlndhwJfQ780zwjk
 9lJEPNzj3+kATukvtA0/KPtYtx9SDOqiCQh1zutgV7QUqKiEz+CsuQg8qQcNdJrntaSiQKfZhUY
 KezvhArtjrn01juVrHQZJoLo22QPDdwJMsv7aMmb29KHemF9AqR3VtrLo8CluOXro3kTPC/V0PH
 jT6RpA2M+HY3z38vfb/TIytVkT8WmQwnqKHO83dH2WIUsTPgEOxB2p9ksjkHGGxee3jZpZK7YSW
 5Uy1HQVQNgoITbFjUWKYs1CcdhvKqhRXjiYyTrybdN7I/Xok8rLH2n7dQrRp/BmDglpUwAs+J6H
 nlw==
X-Received: by 2002:a05:6402:5107:b0:6a5:dfb6:3618 with SMTP id
 4fb4d7f45d1cf-6a60d318ddamr20562239a12.5.1788280683620; Tue, 01 Sep 2026
 09:38:03 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 09:38:03 -0700
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 09:38:03 -0700
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <7ab51a29-a214-4e39-b684-4c4b3b87eca4@kernel.org>
References: <cover.1788213716.git.zhangxp1998@gmail.com>
 <d3fa15836c409ac6028956c06dbe11a8e0149734.1788213716.git.zhangxp1998@gmail.com>
 <7ab51a29-a214-4e39-b684-4c4b3b87eca4@kernel.org>
Date: Tue, 1 Sep 2026 09:38:03 -0700
X-Gm-Features: AcwNN1WxuIF_MdQAaftvkanhT2uP5XsVUqxVS_gAOomGkZ8JkMrI3Z9K18QQNtY
Message-ID: <CAH=xXfHzwJwo-R=neWSHAQkni4OOyT8LKug6T9kbZmkhH6WA_Q@mail.gmail.com>
To: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x1RUw-00062F-Gx
Subject: Re: [f2fs-dev] [PATCH v7 01/11] f2fs: initialize sb_info early in
 f2fs_fill_super
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

Thanks for pointing this out. I have restored unlikely() around the
sb_set_blocksize() failure check for v8.

Thanks,
Kelvin


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
