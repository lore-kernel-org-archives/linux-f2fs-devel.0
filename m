From: grygorii tertychnyi via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH] loop: drop caches if offset or block_size are
 changed
Date: Mon, 15 Apr 2019 14:13:21 -0700
Message-ID: <20190415211321.58681-1-gtertych@cisco.com>
References: <CAPUE2uushZ3Zc6mt01q3OkSx63YmQLq7SKqAktdZVnrb9bVnHA@mail.gmail.com>
Reply-To: grygorii tertychnyi <gtertych@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <gtertych@cisco.com>) id 1hG8v3-0003jz-4a
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Apr 2019 21:13:37 +0000
Received: from rcdn-iport-3.cisco.com ([173.37.86.74])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps (TLSv1.2:DHE-RSA-SEED-SHA:128)
 (Exim 4.90_1) id 1hG8v1-008F0n-J9
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Apr 2019 21:13:37 +0000
In-Reply-To: <CAPUE2uushZ3Zc6mt01q3OkSx63YmQLq7SKqAktdZVnrb9bVnHA@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, gwendal@chromium.org
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, xe-linux-external@cisco.com

Jaegeuk,

We also observed an issue with this patch.

After heavely working with image.bin (haxdump with different offsets)
next mount call fails:

# mount -o ro,loop,offset=45967633 -t squashfs image.bin /tmp/gi45
mount: image.bin: failed to setup loop device: Resource temporarily unavailable

# dmesg | tail -n1
loop_set_status: loop2 () has still dirty pages (nrpages=1)


-- Grygorii
