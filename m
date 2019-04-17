From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: f2fs: SIT corruption upon fsck
Date: Wed, 17 Apr 2019 19:40:12 +0900
Message-ID: <CAD14+f03GwTORdNyKEXo73pTW_1osGfnq6t68mN8w=ipZDrnrQ@mail.gmail.com>
References: <CAD14+f2sT6HbP-vjwWo6A2O151hF=NqcP6_QqLEiEQaZ=QMgoQ@mail.gmail.com>
 <CAD14+f2oNaVbL6X_oHV=C4JMQMBCtH52OY6SSLEAXisza7fANQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hGhzT-00079j-6w
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 10:40:31 +0000
Received: from mail-qt1-f171.google.com ([209.85.160.171])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hGhzR-00CLgx-V8
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 10:40:31 +0000
Received: by mail-qt1-f171.google.com with SMTP id p20so26698435qtc.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Apr 2019 03:40:29 -0700 (PDT)
In-Reply-To: <CAD14+f2oNaVbL6X_oHV=C4JMQMBCtH52OY6SSLEAXisza7fANQ@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Oh sorry, I should have been more careful attaching the kernel log.
Disregard anything before 3091s mark and just pay attention to those 2 lines:

> [ 3091.204798] F2FS-fs (loop1): SIT is corrupted node# 2481418 vs 2517451
> [ 3091.204801] F2FS-fs (loop1): Failed to initialize F2FS segment manager

Thanks.
