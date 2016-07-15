From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 5/5] f2fs: use blk_plug in all the possible paths
Date: Thu, 14 Jul 2016 19:21:32 -0700
Message-ID: <20160715022132.GA1513@infradead.org>
References: <20160715004629.43143-1-jaegeuk@kernel.org>
 <20160715004629.43143-5-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160715004629.43143-5-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Jul 14, 2016 at 05:46:29PM -0700, Jaegeuk Kim wrote:
> The main reason is that blk_start_plug can be used to wake up from low-power
> mode before submitting further bios.

Where does that myth come from?
