From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] f2fs: add an ioctl() to explicitly trigger fsck later
Date: Wed, 5 Dec 2018 20:29:54 +0100
Message-ID: <20181205192954.cv75pkfvqxkayqlz@devuan>
References: <20181129015257.95036-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181129015257.95036-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed 2018-11-28 17:52:57, Jaegeuk Kim wrote:
> This adds an option in ioctl(F2FS_IOC_SHUTDOWN) in order to trigger fsck by
> setting a NEED_FSCK flag.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

I don't expect to use it too often, but it makes sense.
									Pavel
									
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
