From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH] f2fs:Fix locking requirements in the function
 recover_dentry
Date: Sun, 06 Sep 2015 17:41:45 +0800
Message-ID: <009501d0e888$6b679090$4236b1b0$@samsung.com>
References: <1441474037-6931-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1441474037-6931-1-git-send-email-xerofoify@gmail.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Nicholas Krause' <xerofoify@gmail.com>, jaegeuk@kernel.org
Cc: cm224.lee@samsung.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Nicholas Krause [mailto:xerofoify@gmail.com]
> Sent: Sunday, September 06, 2015 1:27 AM
> To: jaegeuk@kernel.org
> Cc: cm224.lee@samsung.com; chao2.yu@samsung.com; linux-f2fs-devel@lists.sourceforge.net;
> linux-kernel@vger.kernel.org
> Subject: [PATCH] f2fs:Fix locking requirements in the function recover_dentry
> 
> This fixes locking requirements in the function recover_dentry to
> properly lock the critical region between the labels retry and out
> with the read/write semaphone of the f2fs's superblock representation
> in order to protect against other concurrent threads of execution

The protecting is not needed, I've already relayed in last thread, please
refer to the link below:

http://www.gossamer-threads.com/lists/linux/kernel/2234556?do=post_view_threaded#2234556

Thanks,
